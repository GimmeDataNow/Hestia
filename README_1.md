This project contains the configurations for all of my nixos machines.

## Project Structure
`tree -a -I '.git'`
```
.
├── flake.lock
├── flake.nix
├── hosts
│   ├── desktop
│   │   ├── configuration.nix
│   │   └── hardware.nix
│   ├── laptop
│   │   ├── configuration.nix
│   │   └── hardware.nix
│   ├── minipc
│   │   ├── configuration.nix
│   │   └── hardware.nix
│   └── vps
│       └── configuration.nix
├── modules
│   ├── home
│   │   ├── desktop.nix
│   │   ├── hyprland
│   │   │   └── default.nix
│   │   ├── shell.nix
│   │   ├── spicetify.nix
│   │   └── wayland.nix
│   └── nixos
│       ├── common
│       │   ├── boot.nix
│       │   ├── common.nix
│       │   └── location.nix
│       ├── desktop
│       │   ├── backlight.nix
│       │   ├── fonts.nix
│       │   ├── gpu-amd.nix
│       │   ├── hyprland.nix
│       │   ├── networking.nix
│       │   ├── power.nix
│       │   ├── printer.nix
│       │   ├── programs
│       │   │   ├── cli.nix
│       │   │   ├── communication.nix
│       │   │   ├── gaming.nix
│       │   │   ├── gui.nix
│       │   │   └── programs.nix
│       │   ├── programs-cli.nix
│       │   ├── programs-gui.nix
│       │   ├── programs.nix
│       │   ├── security.nix
│       │   └── sound.nix
│       └── server
│           ├── common.nix
│           ├── paperless
│           │   ├── docker-compose.yml
│           │   └── service.nix
│           └── portainer
│               ├── docker-compose.yml
│               └── service.nix
└── README.md
```

## Project utilites

## ISO Flashing

caligula

### compose2nix
```
  nix run github:aksiksi/compose2nix -- \
  -inputs=docker-compose.yml \
  -output=compose.nix \
  -include_env_files=true \
  -check_bind_mounts=true \
  -use_upheld_by=true \
  -runtime=docker \
  -project=paperless \
  -root_path=/home/hallow/containers/paperless \
  -env_files=/home/hallow/nixos/modules/nixos/server/paperless/.env,/home/hallow/nixos/modules/nixos/server/paperless/docker-compose.env
```

# Remote
## Remote Hardware Config
nix run github:nix-community/nixos-anywhere -- \
  --flake .#vps \
  --generate-hardware-config nixos-generate-config ./hosts/vps/hardware-configuration.nix \
  root@31.56.233.116
## Remote Rebuild
nixos-rebuild switch \
  --flake .#vps \
  --target-host hallow@31.56.233.116 \
  --build-host hallow@31.56.233.116 \
  --sudo \
  --ask-sudo-password

  nixos-rebuild switch \
  --flake .#minipc \
  --target-host hallow@192.168.0.110 \
  --build-host hallow@192.168.0.110 \
  --sudo \
  --ask-sudo-password

  # AI fixing things

sudo systemctl restart NetworkManager

  If running sudo systemctl restart NetworkManager instantly restores your full speeds for the current boot, your hardware, antennas, and kernel module are completely fine.
The issue is a race condition at startup: NetworkManager is initializing and attempting to configure the Wi-Fi card before the mt7921e kernel module finishes loading its firmware blobs. This timing mismatch causes NetworkManager to fall back to a generic, safe "legacy" state (4 Mbit/s limit) until you manually restart the service.
You can fix this permanently in NixOS by forcing NetworkManager to wait for the Wi-Fi hardware to be fully ready, or by delaying its startup sequence.
Add one (or both) of these configurations to your /etc/nixos/configuration.nix:
## 1. The Clean NixOS Fix: Force NetworkManager to Wait
You can tell systemd that NetworkManager must wait until the network hardware devices are fully initialized by the kernel before starting up.

  systemd.services.NetworkManager.after = [ "network-pre.target" "systemd-udev-settle.service" ];
  systemd.services.NetworkManager.wants = [ "systemd-udev-settle.service" ];

## 2. Alternative Fix: Force Module Loading Early
If the timing is still too close, you can force the Linux kernel to explicitly load the MediaTek Wi-Fi modules at the absolute very beginning of the boot process (during the initial ramdisk phase), long before NetworkManager even thinks about starting.

  boot.initrd.kernelModules = [ "mt7921e" "mt7921-common" ];

## What to do next:

   1. Add those lines to your config file.
   2. Run sudo nixos-rebuild switch.
   3. Reboot your laptop to test if the speeds are normal right from the lock screen.

Did forcing the early module loading or the systemd wait rule successfully eliminate the need to run that manual restart command after you reboot?

If it dynamically drops from 100 Mbit/s down to 4 Mbit/s after a period of active use, you are running into the definitive MT7921e Buffer Bloat / TDLS Failure loop. [1] 
When the chip handles modern peer-to-peer or heavy local network traffic (like metadata syncs, local discovery tools like GSConnect/KDE Connect, or heavy web socket polling), the driver tries to set up a direct connection (TDLS). The kernel rejects it, a "zombie state" builds up in the device's internal memory, and the card aggressively self-throttles to 4–6 Mbit/s to prevent a total hardware crash. [1] 
Because the card is resetting its firmware state on the fly, editing NetworkManager or systemd timing won't prevent the downshift. Try these low-level adjustments to stop the card from panicking:
## 1. Completely Turn Off TDLS (Direct Link) & Crypto Offloading
You can tell the kernel to stop attempting peer-to-peer data links and to disable hardware-level packet encryption slicing, which is what fills the card's microscopic buffer and causes the drop. [1, 2] 
Update your boot.extraModprobeConfig block in /etc/nixos/configuration.nix to look exactly like this:

  boot.extraModprobeConfig = ''
    options mt7921e disable_aspm=1
    options mt7921-common disable_clc=1
    options cfg80211 nohwcrypt=1
  '';

(The nohwcrypt=1 flag forces the CPU to handle the WPA security wrapper instead of letting the buggy MediaTek firmware do it, preventing the buffer crash). [2] 
## 2. Disable Local Discovered Services (If Applicable)
If you are running KDE Connect, GSConnect, Syncthing, or Local Send on your laptop, turn them off completely for a few hours as a test. The packet spam from these background discovery engines triggers the exact 4–6 Mbps zombie drop loop on this specific MediaTek family. [1] 
## 3. Check for a Thermal/Power State Drop
If it happens exactly when you plug/unplug the charger, the laptop's internal power framework might be kicking the PCIe lane into a low-voltage tier. Try disabling the absolute lowest power-saving parameter entirely at the system kernel layer by adding this parameter:

  boot.kernelParams = [ "pcie_aspm=off" "pci=nocrs" ];

------------------------------
## The Reality of this Card
If you change these modprobe flags, run sudo nixos-rebuild switch, reboot, and it still eventually drops to 4 Mbit/s after an hour, you have hit the hardware wall. [3, 4] 
The MediaTek MT7921 / MT7922 family has a massive hardware-level failure rate on Linux where it desynchronizes from modern Wi-Fi 6 routers under sustained load. The absolute best choice for your sanity is to spend $15 on an Intel AX210 M.2 card. It takes 10 minutes to swap out under the HP Envy's bottom panel and permanently resolves the issue by using Intel's pristine iwlwifi stack. [3, 5, 6] 
Let me know if adding nohwcrypt=1 gives you a stable 100 Mbit/s stream that survives over time!

[1] [https://community.frame.work](https://community.frame.work/t/wifi-crashes-on-ubuntu-24-04-with-syncthing-running/82113)
[2] [https://bbs.archlinux.org](https://bbs.archlinux.org/viewtopic.php?id=268866)
[3] [https://forum.endeavouros.com](https://forum.endeavouros.com/t/wifi-slow-occasionally-drops/74635)
[4] [https://discuss.cachyos.org](https://discuss.cachyos.org/t/wifi-becoming-incredibly-slow-and-completely-stops-working-mediatek-7921e/27629)
[5] [https://unix.stackexchange.com](https://unix.stackexchange.com/questions/807095/mediatek-mt7921e-disconnects-exactly-every-60-seconds-on-160-mhz-wi-fi-6-reason)
[6] [https://forums.linuxmint.com](https://forums.linuxmint.com/viewtopic.php?t=441423)


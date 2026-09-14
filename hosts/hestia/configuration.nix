{ pkgs, unstable, inputs, lib, user, ... }: {
  imports = [
    ./hardware.nix

    # Core System Modules
    ../../modules/nixos/common/boot.nix
    ../../modules/nixos/common/common.nix
    ../../modules/nixos/desktop/programs/cli.nix
    ../../modules/nixos/server/common.nix
    ../../modules/nixos/desktop/networking.nix
    # ../../modules/nixos/server/tailscale.nix
    # ../../modules/nixos/server/paperless/compose.nix
    # ../../modules/nixos/server/mealie/compose.nix
    # ../../modules/nixos/server/technitium/compose.nix
    # ../../modules/nixos/server/vaultwarden/default.nix
    # Home Manager (Just for Shell/CLI tools)
    inputs.home-manager.nixosModules.home-manager
  ];
 
  # DONT forget to open the needed ports
  networking.firewall.allowedTCPPorts = [ 22 8000 9443 ];
  networking.firewall.allowedUDPPorts = [];


  # Docker Setup
  virtualisation.docker.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "docker" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgsEnykX81QlWJyUQxsKSbJV4g3WwckVH31o5jXO5ot hallow@desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII4CLEZFzXYaJMZ95RFC7GGpxOUJstTXQ/lgOLo9Lvlc hallow@laptop"
    ];
  };

  # Hostname
  networking.hostName = "hestia";

  # --- HOME MANAGER (CLI ONLY) ---
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs unstable user; };
    backupFileExtension = "bak";
    users.${user} = {
      imports = [
        ../../modules/home/shell.nix # Keep your aliases and bash settings!
        ../../modules/home/starship.nix
        ../../modules/home/kitty.nix
        ../../modules/home/yazi.nix
        ../../modules/home/helix.nix
      ];
      home.stateVersion = "26.05";
    };
  };

  # --- SYSTEM CONFIG ---
  boot.kernelPackages = unstable.linuxPackages_latest;
  system.stateVersion = "26.05"; 
}

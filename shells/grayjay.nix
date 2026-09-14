{pkgs ? import (fetchTarball {
  # url = "https://github.com/NixOS/nixpkgs/archive/72841a4a8761d1aed92ef6169a636872c986c76d.tar.gz";
  url = "https://github.com/NixOS/nixpkgs/archive/fd1462031fdee08f65fd0b4c6b64e22239a77870.tar.gz";

})

 {}}:
(pkgs.buildFHSEnv {
  name = "grayjay-fhs";

  extraOutputsToInstall = [ "lib" "out" "dev" ];

  targetPkgs = pkgs: with pkgs; [
    # Core C / C++ runtime
    stdenv.cc.cc.lib
    zlib
    glib
    icu
    openssl
    udev
    dbus
    util-linux

    # Chromium / CEF dependencies (at-spi2 is crucial for Chromium IPC)
    at-spi2-atk
    at-spi2-core
    nss
    nspr
    atk
    cairo
    pango
    gdk-pixbuf
    gtk3
    fontconfig
    freetype
    libdrm
    mesa
    libgbm
    libGL
    expat
    libsecret
    libnotify
    cups

    # X11 & Wayland
    libX11
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    libxcb
    libXcursor
    libXi
    libXtst
    libXrender
    libXScrnSaver
    libxshmfence
    libxkbcommon
    wayland

    # Audio
    alsa-lib
    alsa-plugins
    libpulseaudio
    pipewire
  ];

  profile = ''
    # Crucial: Allow dotcefnative to locate libcef.so in the local ./cef directory
    export LD_LIBRARY_PATH="$PWD/cef:$LD_LIBRARY_PATH"

    export ALSA_CONFIG_PATH=/etc/asound.conf
    export DISPLAY=''${DISPLAY:-:0}
    export WAYLAND_DISPLAY=''${WAYLAND_DISPLAY}
    export XDG_RUNTIME_DIR=''${XDG_RUNTIME_DIR}
    
    export DOTCEF_NO_SANDBOX=1
  '';

  runScript = "bash";
}).env

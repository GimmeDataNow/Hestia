{ pkgs, lib, user, ... }: {
  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config = {
    allowUnfree = true;
    allowInsecure = true;
    allowBroken = true;

    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  # Set a sensible default, but allow hosts to override it
  time.timeZone = lib.mkDefault "UTC";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Define your user account
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    hashedPassword = "$y$j9T$.1SJTv4b5xb74jNuW5Jos0$saRV3GfwAEGo1M70hUmoQsPs2TIl.klI09rJYD2bl18";
  };

  environment.systemPackages = with pkgs; [
    vim
    helix
    git
    curl
    wget
    bat
    lazyssh
    tree
  ];
}

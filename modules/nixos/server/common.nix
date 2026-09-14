{ pkgs, lib, ... }: {

  # ssh
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
      X11Forwarding = false;
    };
  };

  # prevent bruteforce attacks
  services.fail2ban = {
    enable = true;
    maxretry = 5; # Ban IPs after 5 failed SSH connection attempts
    bantime = "1h"; # Ban duration
  };

  networking.firewall = {
    enable = true;
    # Allow standard web traffic if you're hosting a site later
    allowedTCPPorts = [
      22
    ];
  };

  # Automatically clean up old Nix generations to save disk space
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Use a lighter-weight documentation set for servers
  documentation.enable = false;
  documentation.nixos.enable = false;

  # Essential CLI tools for server management
  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    tmux
    curl
    wget
    rsync
  ];
}

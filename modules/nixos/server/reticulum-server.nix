{ pkgs, ... }:{
  networking.firewall.allowedTCPPorts = [ 
    4242 # Reticulum TCP interface
  ];

  # 2. Native Systemd Service for rnsd
  systemd.services.rnsd = {
    description = "Reticulum Network Stack Daemon";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    
    serviceConfig = {
      # Runs rnsd as a system daemon pointing to a shared directory
      ExecStart = "${pkgs.python3Packages.rns}/bin/rnsd --config /var/lib/reticulum";
      Restart = "always";
      RestartSec = "5s";
      StateDirectory = "reticulum"; # Creates /var/lib/reticulum automatically
      # User = "root"; # Reticulum requires proper interface socket permissions
      User = "hallow"; 
      Group = "users";
    };
  };
}

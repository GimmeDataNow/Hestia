{ ... }: {
 # networking & security
  # networking.hostName = "desktop"; # hostname
  networking.firewall.allowedTCPPorts = [12315 53317]; # 53317 is used by local-send, 12315 by Grayjay
  networking.firewall.allowedUDPPorts = [];
  networking.firewall.allowPing = true;
  networking.enableIPv6 = false;

  networking.networkmanager.enable = true; # use networkmanager

  # Let resolv.conf be managed automatically
  networking.useHostResolvConf = false;
  environment.etc."resolv.conf".source = "/run/systemd/resolve/stub-resolv.conf";

  # Enable systemd-resolved
  # services.resolved = {
  #   enable = true;
  #   dnssec = "false";           # optional
  #   dnsovertls = "false";       # optional
  #   domains = [];
  #   # fallbackDns = [ "1.1.1.1" "1.0.0.1" ];         # fallback if DHCP fails
  #   extraConfig = ''
  #     # Ensure stub resolver is enabled
  #     DNSStubListener=yes
  #   '';
  # };

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNSSEC = "false";
        DNSOverTLS = "false";
        Domains = [ ];
        DNSStubListener = "yes";
        # FallbackDNS = [ "1.1.1.1" "1.0.0.1" ]; # Optional, matches upstream camelCase
      };
    };
  };
}

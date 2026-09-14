{ unstable, ...}: {
  services.tailscale = {
    enable = true;
    package = unstable.tailscale;
    port = 41641;
    useRoutingFeatures = "client";
    extraUpFlags = [ "--accept-routes" ];
  };
}

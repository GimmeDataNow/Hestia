{ pkgs, unstable, ... }: {

  services.vaultwarden = {
    enable = true;
    config = {
      DOMAIN = "https://minipc.tail554692.ts.net";
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
    };
    # package = unstable.vaultwarden;
  };
}

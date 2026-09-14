{ config, pkgs, lib, ... }:

{
  # Enable Docker
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  virtualisation.oci-containers.backend = "docker";

  # Persistent data directory
  systemd.tmpfiles.rules = [
    "d /var/lib/portainer 0750 root root -"
  ];

  virtualisation.oci-containers.containers.portainer = {
    image = "docker.io/portainer/portainer-ce:latest";

    ports = [
      "9443:9443"   # HTTPS UI
      # "9000:9000" # optional HTTP (not recommended)
    ];

    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/var/lib/portainer:/data"
    ];

    extraOptions = [
      "--restart=always"
    ];
  };
}

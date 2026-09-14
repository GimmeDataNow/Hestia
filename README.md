# Hestia
Home server configuration.

# Documentation

Documentation for the server.

## Installation

### ISO Flashing

Use `caligula`, `dd` or balena etcher to flash the iso to a bootable medium.

## Services

This configuration offers several methods to run services.

### docker (medium)

Docker is available on nixos. The installation of Portainer is recommended.

### compose2nix (docker to nix) (medium)

It is possible to convert a docker compose config into a nix flake which can then be natively imported into nix.
The major downside of this is that updating can be very annoying. Ocasionally you need to unlink the file from the config, rebuild, restore the link and rebuild again.
The second issue is that with faulty docker configurations the service will reboot indefinitely.

Use `compose2nix` to convert it.

### nixpkgs (simple)

The nixpkgs website offers many packages some of which can be configured using the nix options.

https://search.nixos.org/packages
https://search.nixos.org/options

### nix flakes (difficult)

Nix flakes can be configured to spawn processes. This is often tedious and complicated.

### nix containers (difficult)

Nix containers can be used as an alternative to docker contains but they present issues when changing their names.

## Remote

Covers topics regarding remote configuration, maintenance and access.

### Remote Hardware Config

To get the hardware config for a specific configuration run this command.

```nix
  nix run github:nix-community/nixos-anywhere -- \
    --flake .#hestia \
    --generate-hardware-config nixos-generate-config ./hardware-configuration.nix \
    hestia@192.168.0.13
```
### Remote Rebuild

To remotely rebuild and/or update the machine run this command.

```nix
  nixos-rebuild switch \
    --flake .#hestia \
    --target-host hestia@192.168.0.13 \
    --build-host hestia@192.168.0.13 \
    --sudo \
    --ask-sudo-password
```nix


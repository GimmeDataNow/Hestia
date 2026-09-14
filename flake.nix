{
  description = "My Unified NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05"; # The stable branch
    unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # The "bleeding edge" branch

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, ... }@inputs: 
  let
    inherit (self) outputs;
    user = "hallow";
    
    # Helper function
    mkSystem = { host, system ? "x86_64-linux" }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { 
        inherit inputs outputs user;
        # This makes 'unstable' available as an argument in every module
        unstable = import inputs.unstable {
          inherit system;
          config = { 
            allowUnfree = true; 
            allowInsecure = true; 
            allowBroken = true; 
            # fix electron always being broken
            permittedInsecurePackages = [
              "electron-39.8.10"
            ];
          };
        };
      };
      modules = [ ./hosts/${host}/configuration.nix ];
    };

  in {
    nixosConfigurations = {
      hestia = mkSystem { host = "hestia"; };
    };
  };
}

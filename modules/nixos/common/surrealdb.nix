{ config, pkgs, ... }:

let
  # Import your custom derivation
  surrealdb-bin = pkgs.callPackage ../../../pkgs/surrealdb-bin.nix { };
in
{
  environment.systemPackages = [
    surrealdb-bin
  ];
}

{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  # Import the Home Manager module from the flake input
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.nord;
    
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      beautifulLyrics # adds better lyrics support
    ];
    
    enabledCustomApps = with spicePkgs.apps; [
      # lyrics-plus
    ];
  };
}

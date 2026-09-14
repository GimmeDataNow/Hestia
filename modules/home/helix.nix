{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    # Helix handles the theme automatically if it's a built-in one like onedark
    settings = {
      theme = "onedark";
      
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
        true-color = true; # Recommended for onedark
        indent-guides.render = true;
      };

      keys.normal = {
        # Move line down
        "C-j" = [ "extend_to_line_bounds" "delete_selection" "paste_after" ];
        # Move line up
        "C-k" = [ "extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" ];
      };

      keys.select = {
        # Move selection down
        "C-j" = [ "delete_selection" "paste_after" "select_mode" ];
        # Move selection up
        "C-k" = [ "delete_selection" "move_line_up" "paste_before" "select_mode" ];
      };
    };
    
    # Optional: Install extra language servers commonly used in NixOS
    extraPackages = with pkgs; [
      nil          # Nix language server
      nixpkgs-fmt  # Nix formatter
    ];
  };
}

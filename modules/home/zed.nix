{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.zed-editor.packages.${pkgs.system}.default
  ];

  # Optional: You can also manage Zed settings here directly
  programs.zed-editor = {
    enable = true;
  #   package = inputs.zed-editor.packages.${pkgs.system}.default;
  #   userSettings = {
  #     theme = "One Dark";
  #     ui_font_size = 16;
  #     buffer_font_size = 14;
  #     vim_mode = false;
  #   };
  };
}

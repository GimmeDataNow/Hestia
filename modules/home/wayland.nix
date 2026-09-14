{ ... }: {
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
    HYPRSHOT_DIR = "$HOME/screenshots";
  };
}

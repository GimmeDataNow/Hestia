{ pkgs, ... }: {
  xdg.portal.config.common.default = "*";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.xwayland.enable = true;

  xdg.portal = {
    enable = true;
    # extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # Good fallback portal
  };

  # Hint: Hint Electron apps to use Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}

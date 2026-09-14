{ pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
  ];
  fonts.fontconfig.defaultFonts = {
    serif = ["UbuntuMono Nerd Font"];
    sansSerif = ["UbuntuSansMono Nerd Font"];
    monospace = ["UbuntuMono Nerd Font Mono"];
  };
}

{ pkgs, unstable, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    steam
    gamescope
    lutris # windows games on linux
    heroic # heroic games launcher
    prismlauncher # minecraft
  ];
}

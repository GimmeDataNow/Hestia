{ pkgs, unstable, inputs, ...}: {
  environment.systemPackages = with pkgs; [
    vesktop # discord
  ];
}

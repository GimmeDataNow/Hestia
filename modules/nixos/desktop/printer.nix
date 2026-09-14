{ pkgs, user, ...}: {

  users.users.${user}.extraGroups = [ "scanner" "lp" ];
  
  hardware.sane.enable = true;
  services.printing.enable = true; # Printing (lp)
  hardware.sane.extraBackends = [
    pkgs.sane-airscan
  ];

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  services.udev.packages = [pkgs.sane-airscan];
}

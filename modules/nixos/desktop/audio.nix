{ ... }: {
  services.pulseaudio.enable = false; # Should be false
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

}

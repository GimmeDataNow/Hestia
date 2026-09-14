{ ... }: {
  security.rtkit.enable = true; # this allows pipewire to handle real-time priority
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true; # enable wireplumber commands
  };
}

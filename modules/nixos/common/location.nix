{ pkgs, ... }: {

  location.provider = "geoclue2";
  
  # Enable the geoclue2 daemon
  services.geoclue2.enable = true;

  # Enable automatic timezone adjustment
  services.localtimed.enable = true;

  # Optional: If you use KDE or GNOME, they have their own toggles,
  # but this ensures the system-level clock stays synced.
  time.timeZone = null; # We set this to null so localtimed can manage it
}

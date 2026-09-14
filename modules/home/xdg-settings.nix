{ pkgs, ... }: {
  # This sets the environment variables that most apps look for
  home.sessionVariables = {
    BROWSER = "zen";
  };

  # This handles the "MIME types" (telling the system that Zen handles web links)
  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "text/html" = "zen.desktop";
  #     "x-scheme-handler/http" = "zen.desktop";
  #     "x-scheme-handler/https" = "zen.desktop";
  #     "x-scheme-handler/about" = "zen.desktop";
  #     "x-scheme-handler/unknown" = "zen.desktop";
  #   };
  # };
}

{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    
    # Font Settings
    font = {
      name = "UbuntuSansMono Nerd Font";
      size = 12.0;
    };

    # Keybindings
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
    };

    # Extra Settings (The 'settings' block handles standard kitty.conf options)
    settings = {
      foreground = "#D8DEE9";
      enable_audio_bell = "no";
      
      # Optional: Add a slight background opacity for that modern look
      # background_opacity = "0.95";
      # confirm_os_window_close = 0;
    };
  };
}

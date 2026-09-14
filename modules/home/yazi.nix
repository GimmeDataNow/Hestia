{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    # Enables shell integration (e.g., bash/zsh/fish helper functions)
    enableBashIntegration = true;

    keymap = {
        mgr.prepend_keymap = [
          { on = [ "g" "l" ]; run = "cd ~/.local";          desc = "Go to ~/.local";          }
          { on = [ "g" "n" ]; run = "cd ~/nixos";           desc = "Go to ~/nixos";           }
          { on = [ "g" "p" ]; run = "cd ~/secondary_drive"; desc = "Go to secondary drive";   }
          { on = [ "g" "u" ]; run = "cd ~/usb";             desc = "Go to USB";               }
          { on = [ "g" "d" ]; run = "cd ~/downloads";       desc = "Go to Downloads";         }
          { on = [ "g" "c" ]; run = "cd ~/.config";         desc = "Go to ~/.config";         }
          { on = [ "g" "h" ]; run = "cd ~/";                desc = "Go to Home";              }
        ];

    };

    settings = {
      log = {
        enabled = false;
      };
      mgr = {
        show_hidden = false;
        sort_dir_first = true;
        show_symlink = true;
      };
    };
  };
}

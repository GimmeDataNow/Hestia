{ pkgs, config, lib, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        
        modules-left = [ "clock" "custom/playerctl" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "custom/screenutil" "group/powah" "wireplumber" "network" ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "<span color=\"#D8DEE9\"></span>";
            "2" = "<span color=\"#D8DEE9\"></span>";
            "3" = "<span color=\"#D8DEE9\"></span>";
            "4" = "<span color=\"#D8DEE9\"></span>";
            "5" = "<span color=\"#D8DEE9\"></span>";
            "6" = "<span color=\"#D8DEE9\"></span>";
            "7" = "<span color=\"#D8DEE9\"></span>";
            "8" = "<span color=\"#D8DEE9\"></span>";
            "9" = "<span color=\"#D8DEE9\"></span>";
            "10" = "<span color=\"#D8DEE9\"></span>";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };

        "clock" = {
          format = "  {:%H:%M   %F %b}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          today-format = "<b>{}</b>";
          on-click = "gnome-calendar";
          on-click-right = "wl-copy $(date '+%Y-%m-%d @ %H:%M')";
        };

        "cpu" = {
          interval = 4;
          format = "󰻠  {usage}%";
          max-length = 6;
          min-length = 6;
          on-click = "kitty -e btop";
          tooltip = false;
          on-scroll-up = "";
          on-scroll-down = "";
        };

        "memory" = {
          interval = 4;
          format = "󰍛 {percentage}%";
          max-length = 6;
          min-length = 6;
          on-scroll-up = "";
          on-scroll-down = "";
        };

        "disk" = {
          format = "  {percentage_used}%";
          on-scroll-up = "";
          on-scroll-down = "";
        };

        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = "{ifname} 󰈀 ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "";
          family = "ipv4";
          tooltip-format-wifi = "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n {bandwidthUpBits}  {bandwidthDownBits}";
          tooltip-format-ethernet = "󰈀 {ifname}\nIP: {ipaddr}\n {bandwidthUpBits}  {bandwidthDownBits}";
          max-length = 7;
          min-length = 7;
        };

        "wireplumber" = {
          format = "󰕾 {volume}%";
          format-muted = " --%";
          max-volume = 150;
          scroll-step = 5;
          max-length = 6;
          min-length = 6;
          on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pavucontrol";
        };

        "custom/screenutil" = {
          format = "  | ";
          on-click = "sh ~/.config/.scripts/screenshot.sh";
          on-click-right = "sh ~/.config/.scripts/color-picker.sh";
        };

        "custom/gpu" = {
          exec = "sh ~/.config/.scripts/nvidia-gpu-query.sh";
          format = "󰕣 {}%";
          interval = 4;
          tooltip = "wow what a cool gpu";
          max-length = 6;
          min-length = 6;
          on-click = "nvidia-settings";
        };

        "custom/playerctl" = {
          exec = "sh ~/.config/.scripts/spotify-status.sh";
          escape = true;
          format = "  {}";
          tooltip = false;
          interval = 1;
          max-length = 40; # Fixed typo from your JSON: 'max-lenght' -> 'max-length'
          on-click = "sh ~/.config/.scripts/spotify-control.sh play-pause";
          on-click-right = "sh ~/.config/.scripts/spotify-status.sh -c";
          on-scroll-up = "sh ~/.config/.scripts/spotify-control.sh previous";
          on-scroll-down = "sh ~/.config/.scripts/spotify-control.sh next";
        };

        "group/powah" = {
          orientation = "inherit";
          drawer = {
            children-class = "childs";
            transition-left-to-right = false;
          };
          modules = [ "cpu" "disk" "memory" ];
        };
      };
    };
    style = ''
      @keyframes blink-warning {
          70% { color: @light; }
          to {
              color: @light;
              background-color: @warning;
          }
      }

      @keyframes blink-critical {
          70% { color: @light; }
          to {
              color: @light;
              background-color: @critical;
          }
      }

      /* COLORS */
      @define-color bg #2E3440;
      @define-color light #D8DEE9;
      @define-color warning #ebcb8b;
      @define-color critical #BF616A;
      @define-color mode #434C5E;
      @define-color workspacesfocused #4C566A;
      @define-color tray @workspacesfocused;
      @define-color sound #EBCB8B;
      @define-color network #5D7096;
      @define-color memory #546484;
      @define-color cpu #596A8D;
      @define-color temp #4D5C78;
      @define-color layout #5e81ac;
      @define-color battery #88c0d0;
      @define-color date #434C5E;
      @define-color time #434C5E;
      @define-color backlight #434C5E;
      @define-color nord_bg #434C5E;
      @define-color nord_bg_blue #546484;
      @define-color nord_light #D8DEE9;
      @define-color nord_light_font #D8DEE9;
      @define-color nord_dark_font #434C5E;

      /* Reset all styles */
      * {
          border: none;
          border-radius: 3px;
          min-height: 0;
          margin: 0.2em 0.2em 0.1em 0.2em;
          font-family: "UbuntuMono Nerd Font";
          font-size: 14px;
      }

      #waybar {
          background: @bg;
          color: @light;
          font-family: "UbuntuMono Nerd Font";
          font-size: 12px;
          font-weight: bold;
      }

      #disk, #clock, #cpu, #memory, #network, 
      #custom-gpu, #custom-playerctl, #custom-screenutil, #wireplumber {
          padding-left: 0.6em;
          padding-right: 0.6em;
      }

      #workspaces button {
          font-weight: bold;
          padding: 0;
          opacity: 0.3;
          background: none;
          font-size: 1em;
      }

      #workspaces button.focused {
          background: @workspacesfocused;
          color: #D8DEE9;
          opacity: 1;
          padding: 0 0.4em;
      }

      #workspaces button.urgent {
          border-color: #c9545d;
          color: #c9545d;
          opacity: 1;
      }

      #window {
          margin-right: 40px;
          margin-left: 40px;
          font-weight: normal;
      }

      #custom-gpu { background: @nord_bg; font-weight: bold; padding: 0 0.6em; }
      #custom-playerctl { background: @nord_bg; padding: 0 0.6em; }
      #network { background: @nord_bg_blue; }
      #memory { background: @nord_bg; }
      #custom-screenutil { background: @nord_bg; }
      #cpu { background: @nord_bg_blue; }
      #clock { background: @nord_bg_blue; }
      #wireplumber { background: @nord_bg; }
      #disk { background: @nord_bg; }

      #powah, #drawer {
          margin: 0;
          padding: 0;
      }
    '';
  };
}

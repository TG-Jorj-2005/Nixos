{config, lib, pkgs, ...}:
{
  programs.waybar = { 
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [ "eDP-1" ];
        spacing = 4;
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        
        modules-left = [ "hyprland/workspaces" "custom/spotify" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "network" "pulseaudio" "battery" "clock" ];
        
        "custom/spotify" = {
          format = " {}";
          max-length = 40;
          # Comandă care funcționează - testează în terminal mai întâi
          exec = "playerctl metadata title 2>/dev/null || echo 'No music playing'";
          # Sau pentru title + artist (decomentează dacă prima nu merge):
          # exec = "playerctl metadata --format '{{ title }} - {{ artist }}' 2>/dev/null || echo 'No music playing'";
          
          exec-if = "pgrep spotify";
          interval = 5;
          
          # Controale click
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          on-scroll-up = "playerctl previous";
          on-scroll-down = "playerctl next";
          
          # Tooltip pentru info suplimentare
          tooltip = true;
          tooltip-format = " Now playing: {}";
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "●";   # Red dot
            "2" = "●";   # Orange dot
            "3" = "●";   # Yellow dot
            "4" = "●";   # Green dot
            "5" = "●";   # Blue dot
            "6" = "●";   # Purple dot
            "7" = "●";   # Pink dot
            "8" = "●";   # Cyan dot
            "9" = "●";   # White dot
            "10" = "●";  # Gray dot
          };
        };
        
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };
        
        "network" = {
          format-wifi = "📶 {essid} ({signalStrength}%)";
          format-ethernet = "🌐 {ipaddr}";
          format-disconnected = "🔗 Disconnected";
          tooltip-format = "📊 {ifname}: {ipaddr}/{cidr}";
        };
        
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "🎧 {icon} {volume}%";
          format-bluetooth-muted = "🎧 🔇 Muted";
          format-muted = "🔇 Muted";
          format-source = "🎤 {volume}%";
          format-source-muted = "🎤❌";
          format-icons = {
            headphone = "🎧";
            hands-free = "📞";
            headset = "🎧";
            phone = "📱";
            portable = "🔊";
            car = "🚗";
            default = ["🔈" "🔉" "🔊"];
          };
          # swap-icon-label = true;  # Comentat - cauza warning
          on-click = "pavucontrol";
          on-click-right = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        };
        
        "battery" = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "⚡ {capacity}%";
          format-plugged = "🔌 {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = ["🪫" "🔋" "🔋" "🔋" "🔋"];
          tooltip-format = "{timeTo}, {capacity}%";
        };
        
        "clock" = {
          format = "🕐 {:%H:%M}";
          format-alt = "📅 {:%Y-%m-%d %H:%M:%S}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 8px;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background-color: transparent; 
        border-radius: 10px;
        color: #cdd6f4; 
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      #workspaces {
        background-color: #313244;
      }

      #workspaces button {
        padding: 0 8px;
        background-color: transparent;
        color: #6c7086; 
        border-radius: 50%;
        transition: all 0.3s ease;
        margin: 0 2px;
      }

      /* Culori pentru workspace-uri - sintaxă corectată */
     /* Culori pentru workspace-uri - folosind clasele corecte */
#workspaces button.workspace-1 { color: #f38ba8 !important; } /* Red */
#workspaces button.workspace-2 { color: #fab387 !important; } /* Orange */
#workspaces button.workspace-3 { color: #f9e2af !important; } /* Yellow */
#workspaces button.workspace-4 { color: #a6e3a1 !important; } /* Green */
#workspaces button.workspace-5 { color: #74c7ec !important; } /* Blue */
#workspaces button.workspace-6 { color: #cba6f7 !important; } /* Purple */
#workspaces button.workspace-7 { color: #f5c2e7 !important; } /* Pink */
#workspaces button.workspace-8 { color: #94e2d5 !important; } /* Cyan */
#workspaces button.workspace-9 { color: #cdd6f4 !important; } /* White */
#workspaces button.workspace-10 { color: #6c7086 !important; } /* Gray */

      #workspaces button:hover {
        background-color: rgba(137, 180, 250, 0.2); 
        border-radius: 50%;
      }

      #workspaces button.active {
        background-color: currentColor !important;
        color: #1e1e2e !important;
        box-shadow: 0 0 10px currentColor;
      }

      #workspaces button.urgent {
        animation: workspace-urgent 1s ease-in-out infinite alternate;
      }

      @keyframes workspace-urgent {
        from { 
          opacity: 1;
        }
        to { 
          opacity: 0.7;
        }
      }

      #window,
      #network,
      #pulseaudio,
      #battery,
      #clock {
        padding: 0 9px;
        margin: 0 3px;
        background-color: #313244; 
        border-radius: 8px;
        color: #cdd6f4; 
      }

      #network {
        color: #89b4fa; 
      }

      #network.disconnected {
        background-color: #f38ba8; 
        color: #1e1e2e;
      }

      #pulseaudio {
        color: #cba6f7; 
      }

      #pulseaudio.muted {
        background-color: #6c7086; 
        color: #45475a; 
      }

      #battery {
        color: #a6e3a1; 
      }

      #clock {
        color: #74c7ec;
      }

      #network:hover,
      #pulseaudio:hover,
      #battery:hover,
      #clock:hover {
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
      }

      /* Spotify styling cu logo și animații */
      #custom-spotify {
        padding: 0 10px;
        margin: 0 3px;
        background: linear-gradient(135deg, #1db954 0%, #1ed760 100%);
        border-radius: 10px;
        color: #000000;
        font-weight: bold;
        animation: spotify-pulse 3s ease-in-out infinite alternate;
        transition: all 0.3s ease;
      }

      #custom-spotify:hover {
        background: linear-gradient(135deg, #1ed760 0%, #1db954 100%);
        box-shadow: 0 6px 16px rgba(29, 185, 84, 0.4);
      }

      /* Animație subtilă pentru când muzica se redă */
      @keyframes spotify-pulse {
        from { 
          opacity: 0.9;
          box-shadow: 0 2px 8px rgba(29, 185, 84, 0.2);
        }
        to { 
          opacity: 1.0;
          box-shadow: 0 4px 12px rgba(29, 185, 84, 0.3);
        }
      }

      /* Când nu se redă muzica */
      #custom-spotify.paused {
        background: linear-gradient(135deg, #535353 0%, #6c6c6c 100%);
        color: #cccccc;
        animation: none;
      }
    '';  
  };
}

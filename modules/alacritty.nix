{ config, pkgs, ... }:
let
  catppuccinColors = {
    background    = "#1e1e2e";  # Mocha background
    foreground    = "#cdd6f4";  # Mocha text
    cursor        = "#f5e0dc";  # Mocha rosewater
    
    # Culori normale
    black         = "#45475a";  # Mocha surface1
    red           = "#f38ba8";  # Mocha pink
    green         = "#a6e3a1";  # Mocha green
    yellow        = "#f9e2af";  # Mocha yellow
    blue          = "#89b4fa";  # Mocha blue
    magenta       = "#f5c2e7";  # Mocha mauve
    cyan          = "#94e2d5";  # Mocha teal
    white         = "#bac2de";  # Mocha subtext1
    
    # Culori bright
    brightBlack   = "#585b70";  # Mocha surface2
    brightRed     = "#f38ba8";  # Mocha pink
    brightGreen   = "#a6e3a1";  # Mocha green
    brightYellow  = "#f9e2af";  # Mocha yellow
    brightBlue    = "#89b4fa";  # Mocha blue
    brightMagenta = "#f5c2e7";  # Mocha mauve
    brightCyan    = "#94e2d5";  # Mocha teal
    brightWhite   = "#a6adc8";  # Mocha subtext0
  };
in
{
  programs.alacritty = {
    enable = true;
    
    settings = {
      # Configurare font
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        size = 13.0;

      };
      
      # Configurare culori Catppuccin Mocha
      colors = {
        primary = {
          background = catppuccinColors.background;
          foreground = catppuccinColors.foreground;
          dim_foreground = "#7f849c";  # Mocha overlay1
        };
        
        cursor = {
          text = catppuccinColors.background;
          cursor = catppuccinColors.cursor;
        };
        
        vi_mode_cursor = {
          text = catppuccinColors.background;
          cursor = catppuccinColors.cursor;
        };
        
        selection = {
          text = catppuccinColors.background;
          background = "#f5e0dc";  # Mocha rosewater
        };
        
        normal = {
          black   = catppuccinColors.black;
          red     = catppuccinColors.red;
          green   = catppuccinColors.green;
          yellow  = catppuccinColors.yellow;
          blue    = catppuccinColors.blue;
          magenta = catppuccinColors.magenta;
          cyan    = catppuccinColors.cyan;
          white   = catppuccinColors.white;
        };
        
        bright = {
          black   = catppuccinColors.brightBlack;
          red     = catppuccinColors.brightRed;
          green   = catppuccinColors.brightGreen;
          yellow  = catppuccinColors.brightYellow;
          blue    = catppuccinColors.brightBlue;
          magenta = catppuccinColors.brightMagenta;
          cyan    = catppuccinColors.brightCyan;
          white   = catppuccinColors.brightWhite;
        };
        
        dim = {
          black   = "#232634";
          red     = "#e78284";
          green   = "#a6d189";
          yellow  = "#e5c890";
          blue    = "#8caaee";
          magenta = "#f4b8e4";
          cyan    = "#81c8be";
          white   = "#b5bfe2";
        };
      };
      
      # Setări generale
      window = {
        opacity = 0.96;
        padding = {
          x = 3;
          y = 3;
        };
        dynamic_padding = true;
        decorations = "full";
        title = "Alacritty";
        class = {
          instance = "Alacritty";
          general = "Alacritty";
        };
      };
      
      # Setări scrolling
      scrolling = {
        history = 10000;
        multiplier = 3;
      };
      
      # Setări mouse
      mouse = {
        hide_when_typing = true;
        bindings = [
          { mouse = "Middle"; action = "PasteSelection"; }
        ];
      };
      
      # Setări cursor
      cursor = {
        style = {
          shape = "Block";
          blinking = "Off";
        };
        unfocused_hollow = true;
        thickness = 0.15;
      };
      
      # Setări terminal
      terminal = {
        shell = {
           program = "${pkgs.zsh}/bin/zsh";
          args = [ "--login" ];
        };
      };
      
      # Setări generale
      general = {
        live_config_reload = true;
      };
    };
  };
}

{ config, pkgs, ... }:
let
  catppuccinColors = {
    background     = "#1e1e2e";  # Mocha background
    foreground     = "#cdd6f4";  # Mocha text
    selected-bg    = "#45475a";  # Mocha surface1
    selected-fg    = "#cdd6f4";  # Mocha text
    urgent-bg      = "#f38ba8";  # Mocha pink
    urgent-fg      = "#1e1e2e";  # Mocha background
    active-bg      = "#89b4fa";  # Mocha blue
    active-fg      = "#1e1e2e";  # Mocha background
    border         = "#89b4fa";  # Mocha blue
    separatorcolor = "#6c7086";  # Mocha overlay0
  };
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    
    terminal = "${pkgs.alacritty}/bin/alacritty";
    
    font = "FiraCode Nerd Font 12";
    
    location = "center";
    
    extraConfig = {
      # Mod
      modi = "drun,run,window,ssh";
      
      # Display
      show-icons = true;
      icon-theme = "Papirus-Dark";
      display-drun = " Apps";
      display-run = " Run";
      display-window = "﩯 Window";
      display-ssh = " SSH";
      
      # Behavior
      disable-history = false;
      hide-scrollbar = true;
      show-match = true;
      sort = true;
      sorting-method = "normal";
      case-sensitive = false;
      cycle = true;
      sidebar-mode = true;
      
      # Layout
      lines = 10;
      columns = 1;
      width = 35;
      fixed-height = false;
      
      # Text
      placeholder = "Caută...";
      
      # Performance
      lazy-grab = true;
      parse-hosts = true;
      parse-known-hosts = true;
    };
    
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg0 = mkLiteral catppuccinColors.background;
        bg1 = mkLiteral catppuccinColors.selected-bg;
        bg2 = mkLiteral "#585b70"; # Mocha surface2
        fg0 = mkLiteral catppuccinColors.foreground;
        fg1 = mkLiteral "#7f849c"; # Mocha overlay1
        fg2 = mkLiteral "#9399b2"; # Mocha overlay2
        red = mkLiteral catppuccinColors.urgent-bg;
        green = mkLiteral "#a6e3a1"; # Mocha green
        yellow = mkLiteral "#f9e2af"; # Mocha yellow
        blue = mkLiteral catppuccinColors.active-bg;
        magenta = mkLiteral "#f5c2e7"; # Mocha mauve
        cyan = mkLiteral "#94e2d5"; # Mocha teal
        
        accent = mkLiteral "@blue";
        urgent = mkLiteral "@red";
        
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        
        margin = mkLiteral "0";
        padding = mkLiteral "0";
        spacing = mkLiteral "0";
      };
      
      "window" = {
        location = mkLiteral "center";
        width = mkLiteral "640";
        border-radius = mkLiteral "8";
        border = mkLiteral "2";
        border-color = mkLiteral "@accent";
        background-color = mkLiteral "@bg0";
        
        # Transparența
        transparency = "real";
      };
      
      "mainbox" = {
        padding = mkLiteral "12";
        background-color = mkLiteral "transparent";
      };
      
      "inputbar" = {
        children = mkLiteral "[ prompt, entry ]";
        background-color = mkLiteral "@bg1";
        text-color = mkLiteral "@fg0";
        border = mkLiteral "0 0 2 0";
        border-color = mkLiteral "@accent";
        border-radius = mkLiteral "6";
        padding = mkLiteral "8 16";
        spacing = mkLiteral "8";
        margin = mkLiteral "0 0 8 0";
      };
      
      "prompt" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@accent";
      };
      
      "entry" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        placeholder-color = mkLiteral "@fg1";
        cursor = mkLiteral "text";
      };
      
      "listview" = {
        background-color = mkLiteral "transparent";
        columns = mkLiteral "1";
        lines = mkLiteral "10";
        cycle = mkLiteral "false";
        dynamic = mkLiteral "true";
        layout = mkLiteral "vertical";
      };
      
      "element" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        orientation = mkLiteral "horizontal";
        border-radius = mkLiteral "4";
        padding = mkLiteral "6 8";
        spacing = mkLiteral "8";
      };
      
      "element normal.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
      };
      
      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg0";
      };
      
      "element normal.active" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg0";
      };
      
      "element selected.normal" = {
        background-color = mkLiteral "@bg1";
        text-color = mkLiteral "@fg0";
      };
      
      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@bg0";
      };
      
      "element selected.active" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg0";
      };
      
      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "24";
        cursor = mkLiteral "inherit";
      };
      
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
      
      "mode-switcher" = {
        background-color = mkLiteral "transparent";
        spacing = mkLiteral "0";
        margin = mkLiteral "8 0 0 0";
      };
      
      "button" = {
        padding = mkLiteral "8 16";
        background-color = mkLiteral "@bg1";
        text-color = mkLiteral "@fg1";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.5";
        border-radius = mkLiteral "4";
        margin = mkLiteral "0 4 0 0";
      };
      
      "button selected.normal" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "@bg0";
      };
      
      "message" = {
        background-color = mkLiteral "@bg1";
        margin = mkLiteral "0";
        padding = mkLiteral "8";
        border-radius = mkLiteral "4";
        border = mkLiteral "0 0 2 0";
        border-color = mkLiteral "@accent";
      };
      
      "textbox" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@fg0";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };
    };
  };
}

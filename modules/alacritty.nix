{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableZshIntegration = true;  
    shell = pkgs.zsh;
    settings = {
      # Tema și culori
      theme = "catppuccin-mocha"; # sau "dark", "light", "auto"
      background-opacity = 0.9;
      
      # Font
      font-family = "JetBrains Mono";
      font-size = 12;
      font-style = "normal";
      
      # Comportament fereastră
      window-decoration = true;
      window-padding-x = 8;
      window-padding-y = 8;
      
      # Cursor
      cursor-style = "block"; # sau "bar", "underline"
      cursor-blink = true;
      
      # Scrolling
      scrollback-limit = 10000;
      
      # Clipboard
      copy-on-select = false;
      
      # Shell integration
      shell-integration-features = "cursor,sudo,title";
      
      # Mouse
      mouse-hide-while-typing = true;
      
      # Diverse
      confirm-close-surface = false;
      gtk-single-instance = false;
    };
    
    # Keybindings personalizate (opțional)
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_surface";
      "ctrl+shift+n" = "new_window";
    };
  };

  };
}


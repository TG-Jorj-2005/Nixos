# kitty.nix
{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    
    # Shell
    shell = "${pkgs.zsh}/bin/zsh";
    shellIntegration.enableZshIntegration = true;
    
    # Font
    font = {
      name = "JetBrains Mono";
      size = 12;
    };
    
    # Tema
    theme = "Catppuccin-Mocha";
    
    settings = {
      # Aspect general
      background_opacity = "0.9";
      dynamic_background_opacity = true;
      
      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = "0.75";
      cursor_stop_blinking_after = "15.0";
      
      # Scrollback
      scrollback_lines = 10000;
      scrollback_pager_history_size = 32;
      
      # Mouse
      copy_on_select = false;
      mouse_hide_wait = "3.0";
      
      # Fereastră
      remember_window_size = true;
      initial_window_width = 1000;
      initial_window_height = 600;
      window_padding_width = 8;
      window_margin_width = 0;
      
      # Tabs
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
      
      # Bell
      enable_audio_bell = false;
      visual_bell_duration = "0.0";
      
      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      
      # Advanced
      shell_integration = "enabled";
      allow_remote_control = false;
      update_check_interval = 24;
      clipboard_control = "write-clipboard write-primary";
      
      # URL handling
      url_style = "curly";
      open_url_with = "default";
      url_prefixes = "http https file ftp gemini irc gopher mailto news git";
      detect_urls = true;
    };
    
    keybindings = {
      # Clipboard
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      
      # Tabs
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      
      # Windows
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+n" = "new_os_window";
      
      # Font size
      "ctrl+plus" = "increase_font_size";
      "ctrl+minus" = "decrease_font_size";
      "ctrl+0" = "restore_font_size";
      
      # Scrolling
      "shift+page_up" = "scroll_page_up";
      "shift+page_down" = "scroll_page_down";
      "shift+home" = "scroll_home";
      "shift+end" = "scroll_end";
      
      # Layout
      "ctrl+shift+l" = "next_layout";
      
      # Search
      "ctrl+shift+f" = "show_scrollback";
    };
  };
}

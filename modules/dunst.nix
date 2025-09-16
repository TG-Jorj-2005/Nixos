{config, lib, pkgs, ...}:

{
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
    settings = {
      font = "JetBrains Mono Medium 10";
      frame_width = 2;
      separator_height = 0;
      transparency = 0;
      background = "#282828";
      foreground = "#ebdbb2";
      format = "%s";
      time_format = "%H:%M";
      ignore_newline = true;
      geometry = "300x50-10+10";
      close_on_click = true;
      sort = "urgency";
      startup_notification = false;
      mouse = true;
      max_icon_size = 32;
      icon_position = "left";
      line_height = 1.2;
      word_wrap = true;
      show_age_threshold = 5;
      frame_color = "#458588";
      low_background = "#3c3836";
      low_foreground = "#ebdbb2";
      normal_background = "#282828";
      normal_foreground = "#ebdbb2";
      critical_background = "#cc241d";
      critical_foreground = "#fbf1c7";
      urgency_low = { timeout = 5; };
      urgency_normal = { timeout = 10; };
      urgency_critical = { timeout = 0; };
                                     };
    

    };

}

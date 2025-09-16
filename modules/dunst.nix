{config, lib, pkgs, ...}:

{
  services.dunst = {
    enable = true;
    package = pkgs.dunst;
    iconTheme = { 
      name =  "Papirus-Dark";
      package = pkgs.papirus-icon-theme;             
      size = "16x16";
           };
    configFile = ''
      [global]
      follow = mouse
      width = 400
      height = 300
      font = JetBrains Mono 10
      origin =  top-right
      offset= 0x25
      padding = 10
      separator_height = 2
      frame_width = 2
      frame_color = "#4c566a"
      separator_color = frame 
      format = "<b>%s</b>\n%b"
      alignment = left
      vertical_alignment = center
      min_icon_size = 0
      max_icon_size = 32
      corner_radius = 4

      [urgency_low]
      background = "#2e3440"
      foreground = "#d8dee9"
      timeout = 5
      frame_color = "#4c566a"
      
      [urgency_normal]
      background = "#3b4252"
      foreground = "#eceff4"
      timeout = 10
      frame_color = "#81a1c1"
      new_icon = bell
       
      [urgency_critical]  
      background = "#bf616a"
      foreground = "#2e3440"
      timeout = 0
      frame_color = "#d08770"
    '';

  };
}

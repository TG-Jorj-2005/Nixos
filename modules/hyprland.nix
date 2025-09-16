{config, lib, pkgs, ... }:
{
home.packages = with pkgs;[
 starship           # Prompt pentru terminal rapid și personalizabil
 rofi
 nitch              # System information tool minimal (neofetch alternativ)
 wlr-randr          # Utilitar pentru configurarea monitoarelor în Wayland
 swww               # Wallpaper daemon pentru Wayland - schimbă fundalul desktop-ului
 ffmpeg             # Suite de tools pentru procesarea video/audio
 wl-clipboard       # Utilities pentru clipboard în Wayland (wl-copy, wl-paste)
 hyprland-protocols # Protocoale Wayland specifice pentru Hyprland
 hyprpicker         # Color picker pentru Hyprland - selectează culori de pe ecran
 xfce.thunar             # File manager (din XFCE) - navigare prin fișiere
 swayidle           # Idle daemon - gestionează acțiuni când PC-ul e inactiv
 gtklock            # Screen locker pentru Wayland - blochează ecranul
 swaybg             # Background/wallpaper setter pentru Wayland
 xdg-desktop-portal-hyprland # Portal pentru integrarea aplicațiilor cu Hyprland
 wlsunset          # Blue light filter pentru Wayland - schimbă temperatura culorilor
 pyprland           # Plugin manager și extensii pentru Hyprland (scris în Python)
 pavucontrol        # PulseAudio Volume Control - interfață grafică pentru audio
 pamixer            # PulseAudio mixer din linia de comandă
 grim               # Screenshot utility pentru Wayland
 slurp         # Utilitar pentru selectarea unei zone de pe ecran (folosit cu grim)
 waybar
 btop
 alacritty
 river-classic

];
wayland = {
 windowManager={
   hyprland={
     enable = true;
     settings = {
              

       #Monitor
       monitor = "eDP-1,1920x1080@60,0x0,1";
       

       #Programer use
        "$terminal" = "alacritty";
	"$fileManager" = "nautilus";
	"$menu" = "rofi -show drun";
	

	#Auto-Start
	exec-once = [
  "lxqt-policykit-agent"
  "pypr"
	"swww-daemon"
	"waybar"
	"alacritty -t btop -e btop"
	"swww img /home/jorj/Pictures/output.gif --transition-type any" ];

	#ENV Variables
	env =[  "XCURSOR_SIZE,24"
              "HYPRCURSOR_SIZE,24"];

        #Imagine 

	general = {
          gaps_in = 3;
	  
	  gaps_out = 10;

	  border_size =2;

	  "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
	  "col.inactive_border" = "rgba(595959aa)";

	  resize_on_border = false;

	  allow_tearing = false;

	  layout = "dwindle";

	};

	decoration = {
           rounding = 10;


	   active_opacity = 0.97;
	   inactive_opacity = 0.97;
           
	   blur = {
	     size = 3;
	     passes = 1;
	     vibrancy = 0.1696;

	     };

	  shadow = {
            
	    range = 4;
	    render_power = 3;
	    color = "rgba(1a1a1aee)";

         	};
	};

	animations = {

	     bezier = [ 
	      "easeOutQuint,0.23,1,0.32,1"
              "easeInOutCubic,0.65,0.05,0.36,1"
              "linear,0,0,1,1"
              "almostLinear,0.5,0.5,0.75,1.0"
              "quick,0.15,0,0.1,1" ];

	      animation = [
	      "global, 1, 10, default"
              "border, 1, 5.39, easeOutQuint"
              "windows, 1, 4.79, easeOutQuint"
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
              "windowsOut, 1, 1.49, linear, popin 87%"
              "fadeIn, 1, 1.73, almostLinear"
              "fadeOut, 1, 1.46, almostLinear"
              "fade, 1, 3.03, quick"
              "layers, 1, 3.81, easeOutQuint"
              "layersIn, 1, 4, easeOutQuint, fade"
              "layersOut, 1, 1.5, linear, fade"
              "fadeLayersIn, 1, 1.79, almostLinear"
              "fadeLayersOut, 1, 1.39, almostLinear"
              "workspaces, 1, 1.94, almostLinear, fade"
              "workspacesIn, 1, 1.21, almostLinear, fade"
              "workspacesOut, 1, 1.94, almostLinear, fade" ];
	};
          dwindle ={
           pseudotile = true;
	   
	   preserve_split = true;
	    };

	   master = { new_status = "master"; };

	   misc ={ 
	   force_default_wallpaper = -1;
	   disable_hyprland_logo = false;
	   };

	 #INPUTS

     input = {
        kb_layout = "us,ro";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification
      };
       
       #gestures = { workspace_swipe = true; };

       device = {
       name = "epic-mouse-v1";
       sensitivity = -0.5;
       };

       ##BINDS

       bind = [
        "SUPER, return, exec, $terminal"
        "SUPER, A, killactive"
        "SUPER, M, exit"
        "SUPER, F, exec, $fileManager"
        "SUPER, V, togglefloating"
        "SUPER, E, exec, $menu"
        "SUPER, P, pseudo" # dwindle
        "SUPER, J, togglesplit" # dwindle
       	"SUPER, S,fullscreen,0"
        "SUPER, Z, fullscreen, 1"        
        # Move focus with mainMod + arrow keys
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        
        # Switch workspaces with mainMod + [0-9]
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
        
        # Screenshot bindings
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"
        
        # Volume and brightness controls
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

      ];
      
      # Mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
          
      windowrulev2 = [
      "workspace 1,class:^(Alacritty)$,title:^(.*btop.*)$"
       "pin,class:^(waybar)$"
      ];


	 
       };
     };
   };
 };
}

#IN CAZ DE CONFLICTE cu ~/.config/hypr/hyprland.conf redenumestel in confdl si fa rebuild la home-manager(se aplica si la restul fisierelor si sa fie git ul up to date cu tot )

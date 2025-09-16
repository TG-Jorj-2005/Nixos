{ inputs, config, pkgs, lib, ... }:
{
  imports = [ ./modules/sh.nix
              ./modules/hyprland.nix
	      ./modules/git.nix
	      ./modules/starhip.nix
	      ./modules/waybar.nix
	      ./modules/rofi.nix
	      ./modules/alacritty.nix
	      ./modules/rust.nix
        ./modules/neovim.nix
        ./modules/dunst.nix
		       ];


 home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;

   theme = {
      package = pkgs.catppuccin-gtk;
      name = "Catppuccin-Mocha";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };

    font = {
      name = "Sans";
      size = 12;
    };
  };

  qt={
  enable = true;
  platformTheme.name = "gtk";
  style = {
    name = "gtk2"; 
   };
  };

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jorj";
  home.homeDirectory = "/home/jorj";

  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    brave
    curl
    wget
    git
    unzip
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code  
    nerd-fonts.hack
    spotify
  ];

  home.file = {
  };
  fonts.fontconfig.enable = true;
  home.sessionVariables = {
     GTK_THEME = "Catppuccin-Mocha";
     TERMINAL = "alacritty";
     HYPRLAND_INSTANCE_SIGNATURE = "XDG_RUNTIME_DIR/hypr";
  };
  
  #Pyprland for wayland
systemd.user.services.pyprland = {
  Unit = {
    Description = "Pyprland Daemon";
    # important: rulează numai după ce sesiunea Hyprland e activă
    After = [ "hyprland-session.target" ];
    PartOf = [ "hyprland-session.target" ];
  };
  Service = {
    ExecStart = "${pkgs.pyprland}/bin/pypr daemon";
    Restart = "on-failure";
    RestartSec = 2;
    # variabila necesară pentru a găsi socketul hyprctl
    Environment = "HYPRLAND_INSTANCE_SIGNATURE=%t";
  };
  Install = {
    WantedBy = [ "hyprland-session.target" ];
  };
};

  programs.home-manager.enable = true;


}

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
        ./modules/yazi.nix
		       ];


 home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
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

  fonts.fontconfig.enable = true;
  home.sessionVariables = {
     GTK_THEME = "Catppuccin-Mocha";
     TERMINAL = "alacritty";

  };
  

  programs.home-manager.enable = true;


}

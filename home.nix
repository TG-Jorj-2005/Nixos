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
  };
  
   nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-onedark-nvim = prev.vimUtils.buildVimPlugin {
            name = "onedark";
            src = inputs.plugin-onedark;
          };
        };
      })
    ];
  };

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      neodev-nvim

      nvim-cmp 
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
  };

  programs.home-manager.enable = true;


}

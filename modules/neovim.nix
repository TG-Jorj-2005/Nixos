{ pkgs, lib, ...}:

{
 programs.neovim = {
    enable = true;
    
    with pkgs.Plugins; [
     
     nvim-cmp
     nvim-lspconfig
     neodev-nvim

     telescope-nvim
     nerdtree

     nvim-treesitter
     nvim-web-devicons
     catppuccin-nvim
     lualine-nvim

     vim-fugitive

     ultisnips

     copilot-vim
     vim-nix
      ];
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;

  };
} 

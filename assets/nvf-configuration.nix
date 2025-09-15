{ pkgs, lib, ... }:
{
vim.theme.enable = true;
vim.theme.name = "gruvbox";
vim.theme.style = "dark";

vim.languages.nix.enable = true;

statusline.lualine.enable = true;
telescope.enable = true;
autocomplete.nvim-cmp.enable = true;

languages = {
 enableLSP= true;
 enableTreesitter = true; 
 
 nix.enable = true;
  ts.enable = true;
  rust.enable = true;
 

 };
}

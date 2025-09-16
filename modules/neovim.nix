{ pkgs, lib, ...}:
{
 programs.neovim = {
    enable = true;
    
   plugins =with pkgs.vimPlugins; [
     
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
    
    extraLuaConfig = ''
    -- Funcție helper pentru setup sigur
    local function safe_setup(plugin_name, config)
      config = config or {}
      local ok, plugin = pcall(require, plugin_name)
      if ok then
        if plugin.setup then
          plugin.setup(config)
          print("✓ Loaded: " .. plugin_name)
        else
          print("⚠ No setup function: " .. plugin_name)
        end
      else
        print("✗ Failed to load: " .. plugin_name)
      end
    end
    
    -- Lista plugin-urilor cu configurări
    local plugin_configs = {
      ["nvim-cmp"] = {},
      neodev = {},
      telescope = {},
      ["nvim-treesitter.configs"] = {},
      catppuccin = {},
      lualine = {},
    }
    
    -- Aplică setup() pentru fiecare plugin din listă
    for plugin_name, config in pairs(plugin_configs) do
      safe_setup(plugin_name, config)
    end
    
    -- Plugin-uri care nu au setup() dar pot avea configurări speciale
    -- NERDTree, vim-fugitive, ultisnips, copilot-vim, vim-nix nu au setup()
    
    print("🚀 Plugin setup complete!")
  '';
  };
} 

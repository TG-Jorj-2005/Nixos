{config, lib, pkgs, ...}:
{
programs.neovim = {
  enable = true;
  plugins = with pkgs.vimPlugins; [
    # CMP și dependențele lui
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer  
    cmp-path
    cmp-cmdline
    luasnip
    cmp_luasnip
    
    # Restul plugin-urilor
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


  extraLuaConfig = ''
    -- init.lua pentru Neovim
    
    -- Configurații generale
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.smartindent = true
    vim.opt.wrap = false
    vim.opt.swapfile = false
    vim.opt.backup = false
    vim.opt.hlsearch = false
    vim.opt.incsearch = true
    vim.opt.termguicolors = true
    vim.opt.scrolloff = 8
    vim.opt.signcolumn = "yes"
    vim.opt.updatetime = 50
    
    -- Leader key
    vim.g.mapleader = " "
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

    vim.cmd.colorscheme("catppuccin")

        -- Configurare nvim-cmp separată
    local ok_cmp, cmp = pcall(require, 'cmp')
    local ok_luasnip, luasnip = pcall(require, 'luasnip')
    
    if ok_cmp and ok_luasnip then
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      
      -- Configurare pentru search
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
      
      -- Configurare pentru command line
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
      
      print("✓ Loaded: nvim-cmp")
    else
      print("✗ Failed to load: nvim-cmp or luasnip")
    end
    
    -- Lista plugin-urilor cu configurări
    local plugin_configs = {
      neodev = {},
      telescope = {},
      ["nvim-treesitter.configs"] = {
        ensure_installed = {},
        highlight = { enable = true },
        indent = { enable = true },
      },
      lualine = {
        options = {
          theme = "catppuccin"
        }
      },
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

home.packages = with pkgs; [
  ripgrep     # pentru telescope live-grep
  fd          # pentru telescope find-files (opțional dar recomandat)
  tree-sitter # pentru nvim-treesitter parser generation
];

} 

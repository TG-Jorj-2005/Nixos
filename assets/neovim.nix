{ pkgs, ... }:

{
  # Instalare Neovim cu configurația LazyVim
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    
    # Plugin-uri de bază necesare pentru LazyVim
    plugins = with pkgs.vimPlugins; [
      # Manager de plugin-uri
      lazy-nvim
      
      # Tema și UI
      catppuccin-nvim
      nvim-web-devicons
      dressing-nvim
      
      # Core utilities
      plenary-nvim
      nvim-lua-utils
      
      # File explorer
      nvim-tree-lua
      
      # Statusline
      lualine-nvim
      
      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      
      # Syntax highlighting
      nvim-treesitter
      nvim-treesitter-textobjects
      
      # LSP
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      
      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      friendly-snippets
      
      # Git integration
      gitsigns-nvim
      vim-fugitive
      
      # Terminal
      toggleterm-nvim
      
      # Indent guides
      indent-blankline-nvim
      
      # Autopairs
      nvim-autopairs
      
      # Comment
      comment-nvim
      
      # Which-key
      which-key-nvim
      
      # Dashboard
      alpha-nvim
    ];
    
    # Configurația Lua pentru LazyVim
    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable",
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)

      -- Configurări generale
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Opțiuni Neovim
      local opt = vim.opt

      opt.autowrite = true
      opt.clipboard = "unnamedplus"
      opt.completeopt = "menu,menuone,noselect"
      opt.conceallevel = 3
      opt.confirm = true
      opt.cursorline = true
      opt.expandtab = true
      opt.formatoptions = "jcroqlnt"
      opt.grepformat = "%f:%l:%c:%m"
      opt.grepprg = "rg --vimgrep"
      opt.ignorecase = true
      opt.inccommand = "nosplit"
      opt.laststatus = 0
      opt.list = true
      opt.mouse = "a"
      opt.number = true
      opt.pumblend = 10
      opt.pumheight = 10
      opt.relativenumber = true
      opt.scrolloff = 4
      opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
      opt.shiftround = true
      opt.shiftwidth = 2
      opt.shortmess:append({ W = true, I = true, c = true })
      opt.showmode = false
      opt.sidescrolloff = 8
      opt.signcolumn = "yes"
      opt.smartcase = true
      opt.smartindent = true
      opt.spelllang = { "en", "ro" }
      opt.splitbelow = true
      opt.splitright = true
      opt.tabstop = 2
      opt.termguicolors = true
      opt.timeoutlen = 300
      opt.undofile = true
      opt.undolevels = 10000
      opt.updatetime = 200
      opt.wildmode = "longest:full,full"
      opt.winminwidth = 5
      opt.wrap = false

      -- Configurare LazyVim
      require("lazy").setup({
        spec = {
          {
            "LazyVim/LazyVim",
            import = "lazyvim.plugins",
            opts = {
              colorscheme = "catppuccin",
              news = {
                lazyvim = true,
                neovim = true,
              },
            },
          },
          { import = "lazyvim.plugins.extras.lang.typescript" },
          { import = "lazyvim.plugins.extras.lang.json" },
          { import = "lazyvim.plugins.extras.lang.python" },
          { import = "lazyvim.plugins.extras.lang.rust" },
          { import = "lazyvim.plugins.extras.lang.go" },
          { import = "lazyvim.plugins.extras.coding.copilot" },
          { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip",
              "tarPlugin",
              "tohtml",
              "tutor",
              "zipPlugin",
            },
          },
        },
      })

      -- Keymaps
      local function map(mode, lhs, rhs, opts)
        local keys = require("lazy.core.handler").handlers.keys
        if not keys.active[keys.parse({ lhs, mode = mode }).id] then
          opts = opts or {}
          opts.silent = opts.silent ~= false
          vim.keymap.set(mode, lhs, rhs, opts)
        end
      end

      -- General
      map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
      map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
      map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
      map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })
      
      -- Better movement
      map("n", "j", "gj")
      map("n", "k", "gk")
      map("v", "j", "gj")
      map("v", "k", "gk")

      -- Better window navigation
      map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
      map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
      map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
      map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

      -- Resize window
      map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
      map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
      map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
      map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

      -- Buffer navigation
      map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
      map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
      map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
      map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
      map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

      -- Clear search
      map("n", "<ESC>", "<cmd>noh<cr>", { desc = "Clear highlights" })

      -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
      map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
      map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
      map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
      map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
      map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

      -- Better indenting
      map("v", "<", "<gv")
      map("v", ">", ">gv")

      -- Terminal
      map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })

      -- Configurări specifice pentru limbaje de programare
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.nix" },
        callback = function()
          vim.bo.filetype = "nix"
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end,
      })

      -- Auto-format pe save pentru anumite limbaje
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.json", "*.nix" },
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    '';
  };

  # Dependințe externe necesare
  home.packages = with pkgs; [
    # LSP servers
    nil # Nix LSP
    lua-language-server
    nodePackages.typescript-language-server
    pyright
    rust-analyzer
    gopls
    
    # Formatters
    stylua
    nixfmt
    black
    prettier
    
    # Tools
    ripgrep
    fd
    git
    gcc
    unzip
    wget
    curl
    
    # Tree-sitter CLI
    tree-sitter
    
    # Node.js pentru unele plugin-uri
    nodejs
  ];

  # Configurare pentru a permite Neovim să folosească dependințele
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Alias-uri utile
  programs.bash.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
  
  programs.zsh.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}

{ pkgs, ... }:

{
  # Instalare Neovim cu configurația LazyVim
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    
    # Plugin-uri instalate prin Nix (nu prin Lazy)
    plugins = with pkgs.vimPlugins; [
      # Core LazyVim
      lazy-nvim
      
      # Colorscheme
      catppuccin-nvim
      tokyonight-nvim
      
      # Icons
      nvim-web-devicons
      
      # UI enhancements
      dressing-nvim
      noice-nvim
      nui-nvim
      
      # Core utilities
      plenary-nvim
      
      # File explorer
      neo-tree-nvim
      
      # Statusline și bufferline
      lualine-nvim
      bufferline-nvim
      
      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      telescope-ui-select-nvim
      
      # Syntax highlighting
      (nvim-treesitter.withPlugins (p: [
        p.lua
        p.nix
        p.javascript
        p.typescript
        p.python
        p.rust
        p.go
        p.json
        p.yaml
        p.html
        p.css
        p.markdown
        p.bash
        p.vim
      ]))
      nvim-treesitter-textobjects
      
      # LSP
      nvim-lspconfig
      mason-nvim
      mason-lspconfig-nvim
      none-ls-nvim
      
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
      lazygit-nvim
      
      # Terminal
      toggleterm-nvim
      
      # Utilities
      indent-blankline-nvim
      nvim-autopairs
      comment-nvim
      which-key-nvim
      alpha-nvim
      persistence-nvim
      mini-nvim
      flash-nvim
      nvim-notify
      
      # Code navigation
      trouble-nvim
      todo-comments-nvim
      
      # Formatting
      conform-nvim
    ];
    
    # Configurația Lua
    extraLuaConfig = ''
      -- Configurări generale
      vim.g.mapleader = " "
      vim.g.maplocalleader = " "

      -- Configurări Neovim
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
      opt.laststatus = 3
      opt.list = true
      opt.mouse = "a"
      opt.number = true
      opt.pumblend = 10
      opt.pumheight = 10
      opt.relativenumber = true
      opt.scrolloff = 4
      opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
      opt.shiftround = true
      opt.shiftwidth = 2
      opt.shortmess:append({ W = true, I = true, c = true, C = true })
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
      opt.fillchars = {
        foldopen = "",
        foldclose = "",
        fold = " ",
        foldsep = " ",
        diff = "╱",
        eob = " ",
      }

      -- Colorscheme
      vim.cmd.colorscheme("catppuccin-mocha")

      -- Bootstrap lazy.nvim dacă nu există
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

      -- Configurare Lazy pentru plugin-uri suplimentare
      require("lazy").setup({
        spec = {
          -- Plugin-uri care se bazează pe dependințe runtime
          {
            "folke/which-key.nvim",
            event = "VeryLazy",
            init = function()
              vim.o.timeout = true
              vim.o.timeoutlen = 300
            end,
            opts = {},
          },
          
          -- Flash pentru navigare rapidă
          {
            "folke/flash.nvim",
            event = "VeryLazy",
            opts = {},
            keys = {
              { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
              { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
              { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
              { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            },
          },
        },
        defaults = {
          lazy = false,
          version = false,
        },
        checker = { enabled = false },
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

      -- Configurare Catppuccin
      require("catppuccin").setup({
        flavour = "mocha",
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          telescope = true,
          which_key = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
      })

      -- Configurare Lualine
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          }
        },
        sections = {
          lualine_a = {"mode"},
          lualine_b = {"branch", "diff", "diagnostics"},
          lualine_c = {"filename"},
          lualine_x = {"encoding", "fileformat", "filetype"},
          lualine_y = {"progress"},
          lualine_z = {"location"}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {"filename"},
          lualine_x = {"location"},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
      })

      -- Configurare Bufferline
      require("bufferline").setup({
        options = {
          mode = "buffers",
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = nil,
          indicator = {
            icon = "▎",
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          max_name_length = 30,
          max_prefix_length = 30,
          tab_size = 21,
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          show_tab_indicators = true,
          persist_buffer_sort = true,
          separator_style = "slant",
          enforce_regular_tabs = true,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = {"close"},
          },
          sort_by = "insert_after_current",
        },
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      })

      -- Configurare Neo-tree
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        sort_case_insensitive = false,
        sort_function = nil,
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            with_expanders = nil,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              added     = "",
              modified  = "",
              deleted   = "✖",
              renamed   = "󰁕",
              untracked = "",
              ignored   = "",
              unstaged  = "󰄱",
              staged    = "",
              conflict  = "",
            }
          },
        },
        commands = {},
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false,
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = {
              "add",
              config = {
                show_path = "none"
              }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          }
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true,
            hide_by_name = {
              "node_modules"
            },
            hide_by_pattern = {
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = {
              --".gitignored",
            },
            never_show = {
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = {
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = false,
            leave_dirs_open = false,
          },
          group_empty_dirs = false,
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = false,
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["og"] = { "order_by_git_status", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
            fuzzy_finder_mappings = {
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
            },
          },
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          group_empty_dirs = true,
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"]  = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
              ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" } },
              ["oc"] = { "order_by_created", nowait = false },
              ["od"] = { "order_by_diagnostics", nowait = false },
              ["om"] = { "order_by_modified", nowait = false },
              ["on"] = { "order_by_name", nowait = false },
              ["os"] = { "order_by_size", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            }
          }
        }
      })

      -- Configurare Telescope
      require("telescope").setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            n = { ["q"] = require("telescope.actions").close },
          },
        },
      })

      -- Load telescope extensions
      pcall(require("telescope").load_extension, "fzf")

      -- Configurare LSP
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Nil LSP pentru Nix
      lspconfig.nil_ls.setup({
        capabilities = capabilities,
        settings = {
          ['nil'] = {
            testSetting = 42,
            formatting = {
              command = { "nixfmt" },
            },
          },
        },
      })

      -- Lua LSP
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = {"vim"},
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      -- Configurare nvim-cmp
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

      -- Configurare gitsigns
      require("gitsigns").setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          follow_files = true
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol',
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,
        preview_config = {
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
      })

      -- Configurare autopairs
      require("nvim-autopairs").setup({})

      -- Configurare comment
      require("Comment").setup({})

      -- Configurare indent-blankline
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = { enabled = false },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
        },
      })

      -- Keymaps
      local function map(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.silent = opts.silent ~= false
        vim.keymap.set(mode, lhs, rhs, opts)
      end

      -- General
      map("i", "jk", "<ESC>", { desc = "Exit insert mode" })
      map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
      map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

      -- Better movement
      map("n", "j", "gj")
      map("n", "k", "gk")

      -- Window navigation
      map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
      map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
      map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
      map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

      -- Buffer navigation
      map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
      map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
      map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

      -- Neo-tree
      map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle file explorer" })
      map("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focus file explorer" })

      -- Telescope
      map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
      map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
      map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
      map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

      -- LSP
      map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
      map("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      map("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
      map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
      map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

      -- Diagnostics
      map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
      map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })

      -- Clear search
      map("n", "<ESC>", "<cmd>noh<cr>", { desc = "Clear highlights" })

      -- Better indenting
      map("v", "<", "<gv")
      map("v", ">", ">gv")

      -- Git
      map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git status" })
      map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Git branches" })
      map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Git commits" })

      -- Configurări pentru Nix
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.nix" },
        callback = function()
          vim.bo.filetype = "nix"
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.expandtab = true
        end,
      })

      -- Format pe save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.lua", "*.nix" },
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })

      -- Highlight on yank
      vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
          vim.highlight.on_yank()
        end,
      })
    '';
  };

  # Pachete necesare
  home.packages = with pkgs; [
    # LSP servers
    nil # Nix LSP
    lua-language-server
    
    # Formatters
    stylua
    nixfmt
    
    # Tools
    ripgrep
    fd
    git
    unzip
    
    # Node.js pentru Mason
    nodejs
  ];

  # Variabile de mediu
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Alias-uri
  programs.bash.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
  
  programs.zsh.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };
}

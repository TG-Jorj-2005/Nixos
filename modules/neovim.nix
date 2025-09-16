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

    #Folder Explorer
    neo-tree-nvim
    nvim-web-devicons
    nui-nvim
    plenary-nvim
    
    # Restul plugin-urilor
    nvim-lspconfig
    neodev-nvim
    telescope-nvim
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

    -- Configurare Catppuccin cu opțiuni
    safe_setup("catppuccin", {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = false,
    })

    vim.cmd.colorscheme("catppuccin")
    
    vim.g.copilot_filetypes = {
      ["*"] = true,
      }

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

   -- Configurare Neo-tree (file explorer ca în LazyVim)
    safe_setup("neo-tree", {
      close_if_last_window = false,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
      sort_case_insensitive = false,
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
          ["<esc>"] = "revert_preview",
          ["P"] = { "toggle_preview", config = { use_float = true } },
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
            "*.meta",
            "*/src/*/tsconfig.json",
          },
          always_show = {
            ".gitignored",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db"
          },
          never_show_by_pattern = {
            ".null-ls_*",
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
          }
        }
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
          }
        }
      }
    })
    
    -- Keybindings pentru Neo-tree (ca în LazyVim)
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Explorer NeoTree (root dir)" })
    vim.keymap.set("n", "<leader>E", ":Neotree toggle float<CR>", { desc = "Explorer NeoTree (float)" })
    vim.keymap.set("n", "<leader>fe", ":Neotree toggle left<CR>", { desc = "Explorer NeoTree (root dir)" })
    vim.keymap.set("n", "<leader>be", ":Neotree toggle show buffers right<CR>", { desc = "Buffer explorer" })
    vim.keymap.set("n", "<leader>ge", ":Neotree toggle show git_status right<CR>", { desc = "Git explorer" })
        
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

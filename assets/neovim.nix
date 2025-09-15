{ config, pkgs, lib, ... }:

let
  # Script pentru editare inteligentă
  nvim-edit = pkgs.writeShellScriptBin "nvim-edit" ''
    #!/usr/bin/env zsh
    
    # Culori pentru output
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
    
    # Funcții helper
    log_info() { echo -e "''${BLUE}[INFO]''${NC} $1"; }
    log_success() { echo -e "''${GREEN}[SUCCESS]''${NC} $1"; }
    log_warning() { echo -e "''${YELLOW}[WARNING]''${NC} $1"; }
    log_error() { echo -e "''${RED}[ERROR]''${NC} $1"; }
    
    show_help() {
        echo -e "''${BLUE}nvim-edit''${NC} - Editor inteligent cu LazyVim"
        echo
        echo -e "''${YELLOW}Utilizare:''${NC}"
        echo "  nvim-edit [opțiuni] <fișier>"
        echo "  nvim-edit <director>  # navighează în director"
        echo
        echo -e "''${YELLOW}Opțiuni:''${NC}"
        echo "  -f, --force-sudo    Forțează sudo"
        echo "  -n, --no-sudo       Nu folosi sudo niciodată"
        echo "  -c, --create        Creează fișierul dacă nu există"
        echo "  -b, --backup        Creează backup"
        echo "  -h, --help          Afișează help"
        echo
        echo -e "''${YELLOW}Exemple:''${NC}"
        echo "  nvim-edit ~/.bashrc              # fișier normal"
        echo "  nvim-edit /etc/hosts             # detectează sudo automat"
        echo "  nvim-edit -f ~/.config/test      # forțează sudo"
        echo "  nvim-edit -c /etc/new-config     # creează cu sudo"
    }
   

    # Detectează dacă fișierul necesită root
    needs_root() {
        local file="$1"
        local dir=$(dirname "$file")
        
        # Directoare care necesită root
        case "$dir" in
            /etc* | /root* | /usr* | /opt* | /boot* | /sys* | /proc*)
                return 0 ;;
            /home* | /tmp* | /var/tmp* | "$HOME"*)
                return 1 ;;
        esac
        
        # Verifică permisiunile directorului
        if [ -d "$dir" ]; then
            if [ ! -w "$dir" ]; then
                return 0
            fi
        fi
        
        # Verifică permisiunile fișierului existent
        if [ -f "$file" ]; then
            if [ ! -w "$file" ]; then
                return 0
            fi
        fi
        
        return 1
    }
    
    # Parsare argumente
    FORCE_SUDO=false
    NO_SUDO=false
    CREATE_FILE=false
    BACKUP=false
    FILE=""
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -f|--force-sudo)
                FORCE_SUDO=true
                shift ;;
            -n|--no-sudo)
                NO_SUDO=true
                shift ;;
            -c|--create)
                CREATE_FILE=true
                shift ;;
            -b|--backup)
                BACKUP=true
                shift ;;
            -h|--help)
                show_help
                exit 0 ;;
            -*)
                log_error "Opțiune necunoscută: $1"
                show_help
                exit 1 ;;
            *)
                FILE="$1"
                shift ;;
        esac
    done
    
    # Verifică dacă a fost specificat un fișier
    if [ -z "$FILE" ]; then
        log_error "Nu ai specificat un fișier!"
        show_help
        exit 1
    fi
    
    # Expandează path-ul
    FILE=$(realpath -m "$FILE")
    
    # Verifică dacă este director
    if [ -d "$FILE" ]; then
        log_info "Deschid directorul: $FILE"
        cd "$FILE"
        ${pkgs.neovim}/bin/nvim .
        exit 0
    fi
    
    # Creează backup dacă este solicitat
    if [ "$BACKUP" = true ] && [ -f "$FILE" ]; then
        BACKUP_FILE="''${FILE}.backup.$(date +%Y%m%d_%H%M%S)"
        if needs_root "$FILE" && [ "$NO_SUDO" = false ]; then
            sudo cp "$FILE" "$BACKUP_FILE"
        else
            cp "$FILE" "$BACKUP_FILE"
        fi
        log_success "Backup creat: $BACKUP_FILE"
    fi
    
    # Creează fișierul dacă nu există și este solicitat
    if [ "$CREATE_FILE" = true ] && [ ! -f "$FILE" ]; then
        local dir=$(dirname "$FILE")
        if [ ! -d "$dir" ]; then
            if needs_root "$dir" && [ "$NO_SUDO" = false ]; then
                sudo mkdir -p "$dir"
            else
                mkdir -p "$dir"
            fi
        fi
        
        if needs_root "$FILE" && [ "$NO_SUDO" = false ]; then
            sudo touch "$FILE"
        else
            touch "$FILE"
        fi
        log_success "Fișier creat: $FILE"
    fi
    
    # Determină dacă trebuie să folosim sudo
    USE_SUDO=false
    if [ "$NO_SUDO" = false ]; then
        if [ "$FORCE_SUDO" = true ] || needs_root "$FILE"; then
            USE_SUDO=true
        fi
    fi

    
    # Lansează editorul
    if [ "$USE_SUDO" = true ]; then
        log_info "Editez cu privilegii root: $FILE"
        sudo -E ${pkgs.neovim}/bin/nvim "$FILE"
    else
        log_info "Editez fișierul: $FILE"
        ${pkgs.neovim}/bin/nvim "$FILE"
    fi
  '';
 in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = false;
    vimAlias = false;
    
    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      nil # Nix LSP
      nodePackages.typescript-language-server
      nodePackages.bash-language-server
      
      # Tools
      ripgrep
      fd
      fzf
      lazygit
      tree-sitter
      
      # Build tools
      nodejs
      python3
      gcc
    ];

    extraLuaConfig = ''
      -- Bootstrap lazy.nvim
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
      end
      vim.opt.rtp:prepend(lazypath)

      -- Configurația de bază
      vim.g.mapleader = " "
      vim.g.maplocalleader = "\\"

      -- Setup LazyVim
      require("lazy").setup({
        spec = {
          -- Import LazyVim și plugin-urile sale
          { "LazyVim/LazyVim", import = "lazyvim.plugins" },
          
          -- Extras utile
          { import = "lazyvim.plugins.extras.editor.mini-files" },
          { import = "lazyvim.plugins.extras.coding.copilot" },
          { import = "lazyvim.plugins.extras.lang.nix" },
          
          -- Plugin-uri custom
          {
            "lambdalisue/suda.vim",
            cmd = { "SudaRead", "SudaWrite" },
            keys = {
              { "<leader>W", "<cmd>SudaWrite<cr>", desc = "Sudo Write" },
              { "<leader>R", "<cmd>SudaRead<cr>", desc = "Sudo Read" },
            },
            config = function()
              vim.g.suda_smart_edit = 1
            end,
          },
          
          {
            "nvim-neo-tree/neo-tree.nvim",
            keys = {
              { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
              { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
            },
          },
          
          {
            "akinsho/toggleterm.nvim",
            keys = {
              { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
            },
            opts = {
              direction = "horizontal",
              size = 15,
            },
          },
        },
        defaults = { 
          lazy = false, 
          version = false,
        },
        checker = { enabled = true },
        performance = {
          rtp = {
            disabled_plugins = {
              "gzip", "matchit", "matchparen", "netrwPlugin",
              "tarPlugin", "tohtml", "tutor", "zipPlugin",
            },
          },
        },
      })
    '';
  };

  home.packages = [
    nvim-edit
  ];

  programs.zsh.shellAliases = {
    vi = "nvim-edit";
    vim = "nvim-edit";
    nvim = "nvim-edit";
    snvim = "nvim-edit --force-sudo";
    edit = "nvim-edit";
  };

  programs.git.extraConfig = {
    core.editor = "nvim-edit";
  };
}

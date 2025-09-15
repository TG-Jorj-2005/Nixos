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

  # Script pentru configurarea rapidă LazyVim
  setup-lazyvim = pkgs.writeShellScriptBin "setup-lazyvim" ''
    #!/usr/bin/env zsh
    
    NVIM_CONFIG="$HOME/.config/nvim"
    NVIM_DATA="$HOME/.local/share/nvim"
    
    echo "🚀 Configurez LazyVim..."
    
    # Backup configurația existentă
    if [ -d "$NVIM_CONFIG" ]; then
        echo "📦 Creez backup..."
        mv "$NVIM_CONFIG" "''${NVIM_CONFIG}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
        if [ -d "$NVIM_DATA" ]; then
        mv "$NVIM_DATA" "''${NVIM_DATA}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Configurare LazyVim
    mkdir -p "$NVIM_CONFIG/lua/config"
    mkdir -p "$NVIM_CONFIG/lua/plugins"
    
    # Init.lua principal
    cat > "$NVIM_CONFIG/init.lua" << 'EOF'
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configurația de bază
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup LazyVim
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.editor.mini-files" },
    { import = "plugins" },
  },
  defaults = { lazy = false, version = false },
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
EOF

    # Plugin pentru editare cu sudo
    cat > "$NVIM_CONFIG/lua/plugins/sudo.lua" << 'EOF'
return {
  "lambdalisue/suda.vim",
  cmd = { "SudaRead", "SudaWrite" },
  keys = {
    { "<leader>W", "<cmd>SudaWrite<cr>", desc = "Sudo Write" },
    { "<leader>R", "<cmd>SudaRead<cr>", desc = "Sudo Read" },
  },
  config = function()
    vim.g.suda_smart_edit = 1
  end,
}
EOF

    # Configurații extra
    cat > "$NVIM_CONFIG/lua/plugins/extras.lua" << 'EOF'
return {
  -- File manager îmbunătățit
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
      { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
    },
  },
  
  -- Terminal integrat
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
}
EOF

    echo "✅ LazyVim configurat!"
    echo "🎯 Lansează 'nvim-edit' pentru a începe!"
    echo "🔑 Comenzi utile:"
    echo "   - <leader>W  → Salvează cu sudo"
    echo "   - <leader>e  → Toggle file explorer"
    echo "   - <C-\\>     → Toggle terminal"
  '';

in {
  programs.zsh.enable = true;
  # Programul principal Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
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
  };

  # Adaugă scripturile în sistem
  home.packages = [
    nvim-edit
    setup-lazyvim
    pkgs.tmux
  ];

  programs.zsh.shellAliases = {
    vi = "nvim-edit";
    vim = "nvim-edit";
    nvim = "nvim-edit";
    snvim = "nvim-edit --force-sudo";
    edit = "nvim-edit";
  };

  # Configurare Git pentru a folosi editorul nostru
  programs.git.extraConfig = {
    core.editor = "nvim-edit";
  };
}

{ config, lib, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    
    # Configurația principală
    settings = {
      manager = {
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = false;
        show_symlink = true;
      };
      
      preview = {
        tab_size = 2;
        max_width = 600;
        max_height = 900;
      };
      
      opener = {
        edit = [
          { run = "nvim-edit \"$@\""; block = true; desc = "Edit with nvim-edit"; }
        ];
        open = [
          { run = "xdg-open \"$@\""; desc = "Open"; }
        ];
        reveal = [
          { run = "dolphin \"$(dirname \"$0\")\""; desc = "Reveal in file manager"; }
        ];
      };
    };

    # Tema Catppuccin Macchiato
    theme = {
      manager = {
        cwd = { fg = "#8bd5ca"; };
        
        # Hovered
        hovered = { fg = "#24273a"; bg = "#8aadf4"; };
        preview_hovered = { underline = true; };
        
        # Find
        find_keyword = { fg = "#eed49f"; italic = true; };
        find_position = { fg = "#f5bde6"; bg = "reset"; italic = true; };
        
        # Marker
        marker_copied = { fg = "#a6da95"; bg = "#a6da95"; };
        marker_cut = { fg = "#ed8796"; bg = "#ed8796"; };
        marker_selected = { fg = "#8aadf4"; bg = "#8aadf4"; };
        
        # Tab
        tab_active = { fg = "#24273a"; bg = "#cad3f5"; };
        tab_inactive = { fg = "#cad3f5"; bg = "#494d64"; };
        tab_width = 1;
        
        # Count
        count_copied = { fg = "#24273a"; bg = "#a6da95"; };
        count_cut = { fg = "#24273a"; bg = "#ed8796"; };
        count_selected = { fg = "#24273a"; bg = "#8aadf4"; };
        
        # Border
        border_symbol = "│";
        border_style = { fg = "#8087a2"; };
      };
      
      status = {
        separator_open = "█";
        separator_close = "█";
        separator_style = { fg = "#494d64"; bg = "#494d64"; };
        
        # Mode
        mode_normal = { fg = "#24273a"; bg = "#8aadf4"; bold = true; };
        mode_select = { fg = "#24273a"; bg = "#a6da95"; bold = true; };
        mode_unset = { fg = "#24273a"; bg = "#f0c6c6"; bold = true; };
        
        # Progress
        progress_label = { fg = "#ffffff"; bold = true; };
        progress_normal = { fg = "#8aadf4"; bg = "#494d64"; };
        progress_error = { fg = "#ed8796"; bg = "#494d64"; };
        
        # Permissions
        permissions_t = { fg = "#8aadf4"; };
        permissions_r = { fg = "#eed49f"; };
        permissions_w = { fg = "#ed8796"; };
        permissions_x = { fg = "#a6da95"; };
        permissions_s = { fg = "#8087a2"; };
      };
      
      input = {
        border = { fg = "#8aadf4"; };
        title = { };
        value = { };
        selected = { reversed = true; };
      };
      
      select = {
        border = { fg = "#8aadf4"; };
        active = { fg = "#f5bde6"; };
        inactive = { };
      };
      
      tasks = {
        border = { fg = "#8aadf4"; };
        title = { };
        hovered = { underline = true; };
      };
      
      which = {
        mask = { bg = "#363a4f"; };
        cand = { fg = "#8bd5ca"; };
        rest = { fg = "#939ab7"; };
        desc = { fg = "#f5bde6"; };
        separator = "  ";
        separator_style = { fg = "#5b6078"; };
      };
      
      help = {
        "on" = { fg = "#f5bde6"; };
        exec = { fg = "#8bd5ca"; };
        desc = { fg = "#939ab7"; };
        hovered = { bg = "#5b6078"; bold = true; };
        footer = { fg = "#494d64"; bg = "#cad3f5"; };
      };
      
      filetype = {
        rules = [
          # Media
          { mime = "image/*"; fg = "#8bd5ca"; }
          { mime = "{audio,video}/*"; fg = "#eed49f"; }
          
          # Archives  
          { mime = "application/{,g}zip"; fg = "#f5bde6"; }
          { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}"; fg = "#f5bde6"; }
          
          # Fallback
          { name = "*"; fg = "#cad3f5"; }
          { name = "*/"; fg = "#8aadf4"; }
        ];
      };
    };
    
    # Key mappings
    keymap = {
      manager.prepend_keymap = [
        { on = [ "l" ]; run = "plugin --sync smart-enter"; desc = "Enter the child directory, or open the file"; }
        { on = [ "h" ]; run = "leave"; desc = "Go back to the parent directory"; }
        { on = [ "<C-s>" ]; run = "escape --visual --select"; desc = "Cancel selection"; }
        { on = [ "y" ]; run = [ "yank" ]; desc = "Copy the selected files"; }
        { on = [ "x" ]; run = [ "yank --cut" ]; desc = "Cut the selected files"; }
        { on = [ "p" ]; run = "paste"; desc = "Paste the files"; }
        { on = [ "P" ]; run = "paste --force"; desc = "Paste the files (overwrite)"; }
        { on = [ "d" ]; run = [ "remove" ]; desc = "Move the files to the trash"; }
        { on = [ "D" ]; run = [ "remove --permanently" ]; desc = "Permanently delete the files"; }
        { on = [ "a" ]; run = "create"; desc = "Create a file or directory"; }
        { on = [ "r" ]; run = "rename --cursor=before_ext"; desc = "Rename a file or directory"; }
        { on = [ ";" ]; run = "shell"; desc = "Run a shell command"; }
        { on = [ ":" ]; run = "shell --block"; desc = "Run a shell command (block the UI)"; }
        { on = [ "." ]; run = "hidden toggle"; desc = "Toggle the visibility of hidden files"; }
        { on = [ "s" ]; run = "search fd"; desc = "Search files by name using fd"; }
        { on = [ "S" ]; run = "search rg"; desc = "Search files by content using ripgrep"; }
        { on = [ "<C-q>" ]; run = "close"; desc = "Close the current tab, or quit if it is last tab"; }
        { on = [ "t" ]; run = "tab_create --current"; desc = "Create a new tab using the current path"; }
      ];
    };

    # Plugin-uri și configurații suplimentare
    plugins = {
      smart-enter = ./smart-enter.yazi;
    };
  };

  # Script helper pentru smart-enter
  home.file.".config/yazi/plugins/smart-enter.yazi/init.lua".text = ''
    return {
      entry = function()
        local h = cx.active.current.hovered
        if h and h.cha.is_dir then
          ya.manager_emit("enter", {})
        else
          ya.manager_emit("open", {})
        end
      end,
    }
  '';

  # Integrare cu nvim-edit din configurația anterioară
  programs.zsh.shellAliases = {
    y = "yazi";
    fm = "yazi";
  };

  # Configurația pentru file opener
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "inode/directory" = ["yazi.desktop"];
    };
    defaultApplications = {
      "inode/directory" = ["yazi.desktop"];
    };
  };

  # Desktop entry pentru Yazi
  xdg.desktopEntries.yazi = {
    name = "Yazi";
    comment = "Blazing fast terminal file manager";
    icon = "folder";
    exec = "yazi %F";
    categories = [ "System" "FileManager" ];
    mimeType = [ "inode/directory" ];
  };
}

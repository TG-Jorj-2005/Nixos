{config, libs, pkgs, ...}:
{

 programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
     shell = "${pkgs.zsh}/bin/zsh";
    terminal = "screen-256color";
     plugins = with pkgs.tmuxPlugins; [
    vim-tmux-navigator
    catppuccin
  ]; 
    extraConfig = ''
    # configurația ta aici, dar fără secțiunea de plugin-uri
    unbind r
    bind r source-file ~/.tmux.conf
    set -g default-terminal "tmux-256color"
    set -ag terminal-overrides ",xterm-256color:RGB"
    set -g prefix C-s
    unbind C-b
    bind C-s send -prefix
    set -g mouse on
    set-window-option -g mode-keys vi
    bind-key h select-pane -L
    bind-key j select-pane -D
    bind-key k select-pane -U
    bind-key l select-pane -R
    set-option -g status-position top
    set -g @catppuccin_window_status_style "rounded"
    set -g status-left ""
    set -g status-right "#{E:@catppuccin_status_application} #{E:@catppuccin_status_session}"
    set -g status-style bg=default
  '';

  };

 }

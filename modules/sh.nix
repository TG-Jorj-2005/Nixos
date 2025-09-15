{config, pkgs, ...}:
let
  alias = {
   
   ll = "ls -l";
   ".." = "cd ..";
   jrj = ''if [[ $(git status --porcelain) ]]; then
  sudo git add .
  sudo git commit -m "Automated commit $(date)"
  git push --set-upstream origin main
else
  echo "No changes to commit"
fi'';
   con = "nix-instantiate --parse";
   nrb = "sudo nixos-rebuild switch --flake .";
   hmn = "home-manager switch --flake .#jorj";
   nfu = "sudo nix flake update";
   all = ''
      echo "🔄 Starting full system update..."
      echo "📝 Committing changes..."
      jrj
      echo "🔧 Updating flake..."
      nfu
      echo "🏗️  Rebuilding NixOS..."
      nrb
      echo "🏠 Updating home-manager..."
      hmn
      echo "📝 Final commit..."
      jrj
      echo "✅ All updates completed!"
   '';
   sec= ''   
      echo "🔧 Updating flake..."
      nfu
      echo "🏗️  Rebuilding NixOS..."
      nrb
      echo "🏠 Updating home-manager..."
      hmn
      '';
    da = ''
    cd /home/jorj/.local/share/nvim/lazy
    for d in */; do
    if [ -d "$d/.git" ]; then
    git -C "$d" reset --hard HEAD
    git -C "$d" clean -fd
     fi
     done
'';
    };
in
{
programs.zsh = {
enable = true;

enableCompletion = true;

autosuggestion.enable = true;

syntaxHighlighting.enable = true;

shellAliases = alias;

initContent = ''
    if [[ $- == *i* ]]; then
      nitch
    fi
    
    # Restart tmux pentru a aplica configurația
   if command -v tmux &> /dev/null; then
    if ! tmux has-session 2>/dev/null; then
        tmux kill-server 2>/dev/null || true
    fi
   fi

    export EDITOR="code"
    export TERMINAL="alacritty"
   '';
   history = {
      size = 10000;
      save = 10000;
      share = true;
      ignoreDups = true;
    };
      oh-my-zsh = {
      enable = true;
      theme = "agnoster"; # funcționează bine cu Catppuccin
      plugins = [ 
        "git" 
        "sudo" 
        "history" 
        "colored-man-pages"
        "command-not-found"
      ];
    };
};




}

{ config, pkgs, ... }:

{
  # Enable Alacritty terminal
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };

  # Configure the Alacritty config file in TOML
  home.file.".config/alacritty/alacritty.toml".text = ''
    [window]
    padding = { x = 10, y = 10 }
    dynamic_title = true
    decorations = "Full"
    startup_mode = "Windowed"
    title = "Alacritty"

    [font]
    [font.normal]
    family = "JetBrains Mono"
    style = "Regular"

    [font.bold]
    family = "JetBrains Mono"
    style = "Bold"

    [font.italic]
    family = "JetBrains Mono"
    style = "Italic"

    size = 12.0

    [font.offset]
    x = 0
    y = 0

    [font.glyph_offset]
    x = 0
    y = 0

    use_thin_strokes = false

    [shell]
    program = "/bin/zsh"
    args = ["-l"]
  '';
}


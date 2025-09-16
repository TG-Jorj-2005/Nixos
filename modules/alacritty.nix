{ config, lib, pkgs, ... }:
{

 programs.alacritty= {
       enable = true;
       theme = "dracula";
       package = pkgs.alacritty;

};
 
home.file.".config/alacritty/alacritty.toml".text = ''
  window={
    padding = {
      x = 10;
      y = 10;
    }
    dynamic_title = true;
    decorations = "Full";
    startup_mode = "Windowed";
    title = "Alacritty";
  }
  font = {
    normal = {
      family = "JetBrains Mono";
      style = "Regular";
    }
    bold = {
      family = "JetBrains Mono";
      style = "Bold";
    }
    italic = {
      family = "JetBrains Mono";
      style = "Italic";
    }
    size = 12.0;
    offset = {
      x = 0;
      y = 0;
    }
    glyph_offset = {
      x = 0;
      y = 0;
    }
    use_thin_strokes = false;
  }
  terminal ={
  shell = ["/bin/zsh"];
  shell_args = ["-l"];
  }
  '';
}

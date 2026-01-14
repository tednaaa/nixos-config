{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "Horizon";
      font-size = 12;
      font-family = "JetBrainsMonoNL Nerd Font Propo";
      font-style = "Medium";
    };
  };
}

# keyboard shortcuts
# https://gist.github.com/hensg/43bc71c21d1f79385892352a390aa2ca

{ config, pkgs, lib, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = { x = 10; y = 10; };

      font = {
        normal = {
          family = "JetBrainsMonoNL Nerd Font Propo";
          style = "Medium";
        };
        size = 12;
      };

      terminal = {
        shell = {
          args = [ "--login" "-c" "zellij" ];
          program = "${pkgs.fish}/bin/fish";
        };
      };
    };
  };
}

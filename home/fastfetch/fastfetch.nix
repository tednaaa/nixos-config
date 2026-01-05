{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.fastfetch = {
    enable = true;
    # settings = {
    #   include = [ "$HOME/nixos-config/home/fastfetch/config.jsonc" ];
    # };
    config = ./config.jsonc;
  };
}

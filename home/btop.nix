{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
    };
  };
}

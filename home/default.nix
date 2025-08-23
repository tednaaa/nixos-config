{ config, pkgs, lib, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.configs";

  symlinks = {
    "hypr"              = ".config/hypr";
    "waybar"            = ".config/waybar";
    "rofi"              = ".config/rofi";
    "yazi"              = ".config/yazi";

    "alacritty"         = ".config/alacritty";
    "zellij"            = ".config/zellij";

    "zed"               = ".config/zed";

    "lazygit"           = ".config/lazygit";

    "fish/config.fish"  = ".config/fish/config.fish";
    "git/.gitconfig"    = ".gitconfig";
    "npm/.npmrc"        = ".npmrc";
  };

  mkLinks = lib.mapAttrs' (src: target: {
    name = target;
    value.source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${src}";
  }) symlinks;

in {
  home.username = "tedna";
  home.homeDirectory = "/home/tedna";
  home.stateVersion = "25.11";

  programs.git.enable = true;
  programs.starship.enable = true;
  programs.fish.enable = false;

  home.file = mkLinks;
}

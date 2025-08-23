{ config, pkgs, lib, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.configs";

  symlinks = {
    "hypr"              = ".config/hypr";
    "waybar"            = ".config/waybar";
    "walker"            = ".config/walker";
    "yazi"              = ".config/yazi";

    "alacritty"         = ".config/alacritty";
    "zellij"            = ".config/zellij";
    "wezterm"           = ".config/wezterm";

    "zed"               = ".config/zed";
    "nvim"              = ".config/nvim";

    "lazygit"           = ".config/lazygit";
    "mise"              = ".config/mise";

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

{ config, pkgs, lib, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.configs";

  symlinks = {
    "hypr"   = ".config/hypr";
    "waybar" = ".config/waybar";
    "rofi"   = ".config/rofi";
    "yazi"   = ".config/yazi";
    "satty"  = ".config/satty";

    "fish/config.fish" = ".config/fish/config.fish";
    "fish/functions"   = ".config/fish/functions";

    "zellij"  = ".config/zellij";
    "zed"     = ".config/zed";
    "lazygit" = ".config/lazygit";

    "git/.gitconfig" = ".gitconfig";
    "npm/.npmrc"     = ".npmrc";
  };

  mkLinks = lib.mapAttrs' (src: target: {
    name = target;
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${src}";
    };
  }) symlinks;

in {
  imports = [ ./theme.nix ./alacritty.nix ];

  home.username = "tedna";
  home.homeDirectory = "/home/tedna";
  home.stateVersion = "25.11";

  home.file = mkLinks;
}

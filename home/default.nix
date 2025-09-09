{ config, pkgs, lib, ... }:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.configs";
  home_dots = "${config.home.homeDirectory}/nixos-config/home";

  external_symlinks = {
    "hypr"   = ".config/hypr";
    "waybar" = ".config/waybar";
    "rofi"   = ".config/rofi";
    "yazi"   = ".config/yazi";
    "satty"  = ".config/satty";

    "zellij"  = ".config/zellij";
    "zed"     = ".config/zed";
    "lazygit" = ".config/lazygit";

    "git/.gitconfig" = ".gitconfig";
    "npm/.npmrc"     = ".npmrc";
  };

  home_dots_symlinks = {
    "fish/config.fish" = ".config/fish/config.fish";
    "fish/functions"   = ".config/fish/functions";
  };

  mkExternalLinks = lib.mapAttrs' (src: target: {
    name = target;
    value.source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/${src}";
  }) external_symlinks;

  mkHomeDotsLinks = lib.mapAttrs' (src: target: {
    name = target;
    value.source = config.lib.file.mkOutOfStoreSymlink "${home_dots}/${src}";
  }) home_dots_symlinks;

  allLinks = mkExternalLinks // mkHomeDotsLinks;
in {
  imports = [ ./theme.nix ./alacritty.nix ];

  home.username = "tedna";
  home.homeDirectory = "/home/tedna";
  home.stateVersion = "25.11";

  home.file = allLinks;
}

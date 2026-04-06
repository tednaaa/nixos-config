{
  config,
  lib,
  username,
  ...
}:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/.configs";
  home_dots = "${config.home.homeDirectory}/nixos-config/home";

  external_symlinks = {
    "waybar" = ".config/waybar";
    "rofi" = ".config/rofi";
    "yazi" = ".config/yazi";
    "satty" = ".config/satty";

    "wallpapers" = ".config/wallpapers";

    "zellij" = ".config/zellij";
    "zed" = ".config/zed";

    "lazygit" = ".config/lazygit";
    "lazydocker" = ".config/lazydocker";

    "git/.gitconfig" = ".gitconfig";
    "npm/.npmrc" = ".npmrc";
  };

  home_dots_symlinks = {
    "niri" = ".config/niri";

    "fish/config.fish" = ".config/fish/config.fish";
    "fish/functions" = ".config/fish/functions";
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
in
{
  imports = [
    ./theme.nix
    ./alacritty.nix
    ./btop.nix
    ./direnv.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  home.file = allLinks;
}

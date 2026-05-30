{
  config,
  lib,
  username,
  ...
}:
let
  home_dots = "${config.home.homeDirectory}/nixos-config/home";

  home_dots_symlinks = {
    "niri" = ".config/niri";
    "wallpapers" = ".config/wallpapers";

    "waybar" = ".config/waybar";
    "rofi" = ".config/rofi";
    "yazi" = ".config/yazi";
    "zellij" = ".config/zellij";

    "satty" = ".config/satty";

    "nvim" = ".config/nvim";
    "zed" = ".config/zed";

    "lazygit" = ".config/lazygit";
    "lazydocker" = ".config/lazydocker";

    "git/.gitconfig" = ".gitconfig";
    "npm/.npmrc" = ".npmrc";

    "claude/settings.json" = ".claude/settings.json";
    "claude/CLAUDE.md" = ".claude/CLAUDE.md";

    "fish/config.fish" = ".config/fish/config.fish";
    "fish/functions" = ".config/fish/functions";
  };

  mkHomeDotsLinks = lib.mapAttrs' (src: target: {
    name = target;
    value.source = config.lib.file.mkOutOfStoreSymlink "${home_dots}/${src}";
  }) home_dots_symlinks;

  allLinks = mkHomeDotsLinks;
in
{
  imports = [
    ./theme.nix
    ./alacritty.nix
    ./btop.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  home.file = allLinks;
}

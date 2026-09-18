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
    "fuzzel/fuzzel.ini" = ".config/fuzzel/fuzzel.ini";
    "yazi" = ".config/yazi";
    "zellij" = ".config/zellij";
    "foot/foot.ini" = ".config/foot/foot.ini";

    "satty" = ".config/satty";
    "clipse/config.json" = ".config/clipse/config.json";

    "zed" = ".config/zed";
    "helix" = ".config/helix";
    "nvim" = ".config/nvim";

    "lazygit" = ".config/lazygit";
    "lazydocker" = ".config/lazydocker";

    "fd/ignore" = ".config/fd/ignore";

    "git/.gitconfig" = ".gitconfig";
    "git/ignore" = ".config/git/ignore";
    "npm/.npmrc" = ".npmrc";

    "opencode/opencode.jsonc" = ".config/opencode/opencode.jsonc";
    "opencode/tui.jsonc" = ".config/opencode/tui.jsonc";
    "opencode/commands" = ".config/opencode/commands";

    "claude/settings.json" = ".claude/settings.json";
    "claude/scripts" = ".claude/scripts";

    "agents/AGENTS.md" = [
      ".config/opencode/AGENTS.md"
      ".claude/CLAUDE.md"
    ];
    "agents/skills" = [
      ".agents/skills"
      ".claude/skills"
    ];
    "agents/rules" = [
      ".agents/rules"
      ".claude/rules"
    ];

    "fish/config.fish" = ".config/fish/config.fish";
    "fish/functions" = ".config/fish/functions";
    "fish/conf.d" = ".config/fish/conf.d";
  };

  mkHomeDotsLinks = lib.concatMapAttrs (
    src: targets:
    lib.listToAttrs (
      map (target: {
        name = target;
        value.source = config.lib.file.mkOutOfStoreSymlink "${home_dots}/${src}";
      }) (lib.toList targets)
    )
  ) home_dots_symlinks;

  allLinks = mkHomeDotsLinks;
in
{
  imports = [
    ./theme.nix
    ./foot.nix
    ./btop.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "26.05";

  home.file = allLinks;
}

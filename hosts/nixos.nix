{ ... }: {
  imports = [
    ../modules/apps.nix
    ../modules/base.nix
    ../modules/fonts.nix
    ../modules/gaming.nix
    ../modules/hyprland.nix
    ../modules/terminal.nix
    ../modules/users.nix
    ./hardware-configuration.nix
  ];
}

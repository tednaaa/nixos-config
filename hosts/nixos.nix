{ ... }:
{
  imports = [
    ../modules/apps.nix
    ../modules/base.nix
    ../modules/fonts.nix
    ../modules/gaming.nix
    ../modules/dev.nix
    ../modules/users.nix

    ../modules/niri.nix
    # ../modules/hyprland.nix

    ./hardware-configuration.nix
  ];
}

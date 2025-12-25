{ ... }:
{
  imports = [
    ../modules/core.nix
    ../modules/networking.nix
    ../modules/users.nix
    ../modules/niri.nix
    ../modules/fonts.nix
    ../modules/dev.nix
    ../modules/apps.nix
    ../modules/gaming.nix

    ./hardware-configuration.nix
  ];
}

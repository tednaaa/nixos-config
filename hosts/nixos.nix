{ ... }:
{
  imports = [
    ../modules/core.nix
    ../modules/networking.nix
    ../modules/users.nix
    ../modules/niri.nix
    ../modules/media.nix
    ../modules/fonts.nix
    ../modules/dev.nix
    ../modules/pentest.nix
    ../modules/docker.nix
    ../modules/apps.nix
    ../modules/gaming.nix

    ./hardware-configuration.nix
  ];
}

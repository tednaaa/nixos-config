{ ... }:
{
  imports = [
    ../modules/core.nix
    ../modules/networking.nix
    ../modules/users.nix
    ../modules/media.nix
    ../modules/fonts.nix
    ../modules/apps.nix
    ../modules/dev.nix
    ../modules/docker.nix
    ../modules/gaming.nix
    ../modules/nvidia.nix
    ../modules/niri.nix
    # ../modules/pentest.nix

    ./hardware-configuration.nix
  ];
}

{ ... }: {
  imports = [
    ../modules/base.nix
    ../modules/desktop.nix
    ../modules/fonts.nix
    ../modules/users.nix
    ./hardware-configuration.nix
  ];
}

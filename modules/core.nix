{
  pkgs,
  inputs,
  username,
  ...
}:
{
  system.stateVersion = "26.05";

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
      username
    ];
  };

  nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader = {
    limine.enable = true;
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Asia/Yerevan";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.graphics.enable = true;

  nixpkgs.config.allowUnfree = true;
}

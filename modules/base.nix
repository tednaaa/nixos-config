{
  config,
  pkgs,
  username,
  ...
}:
{
  nix.settings.trusted-users = [
    "root"
    username
  ];

  system.stateVersion = "25.11";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.kernelPackages = pkgs.linuxPackages;
  boot.loader = {
    limine.enable = true;
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  services.resolved.enable = true;

  time.timeZone = "Asia/Yerevan";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.bluetooth.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
  hardware.graphics.enable = true;
  hardware.nvidia.open = false;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nixpkgs.config.allowUnfree = true;
}

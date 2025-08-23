{ pkgs, ... }: {
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia.open = false;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb.layout = "us";

  services.printing.enable = true;
}

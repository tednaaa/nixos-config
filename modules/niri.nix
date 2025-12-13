{ pkgs, ... }:
{
  # remove later
  programs.dconf.enable = false;

  programs = {
    niri.enable = true;
  };

  services = {
    displayManager.gdm.enable = true;
    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # https://wiki.nixos.org/wiki/Wayland#Electron_and_Chromium
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    rofi
    waybar

    swaylock
    swaybg
    swaynotificationcenter

    pulseaudio
    pavucontrol
    brightnessctl
    libnotify

    satty
    grim
    slurp

    mpv
    clipse
    wl-clipboard
    wl-clip-persist
    bluetui
    p7zip
    nautilus
  ];
}

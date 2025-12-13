{ pkgs, ... }:
{
  programs = {
    niri.enable = true;
    waybar.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;
  };

  security = {
    polkit.enable = true;
    pam.services.swaylock = { };
  };

  # https://wiki.nixos.org/wiki/Wayland#Electron_and_Chromium
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    ly
    xdg-desktop-portal-gnome
    xdg-desktop-portal-gtk
    rofi
    swaylock
    swaybg
    swaynotificationcenter
    pavucontrol
    brightnessctl
    libnotify
    satty
    grim
    slurp
    apple-cursor
    papirus-icon-theme
    orchis-theme
    mpv
    clipse
    wl-clipboard
    wl-clip-persist
    bluetui
    p7zip

    kdePackages.dolphin
  ];
}

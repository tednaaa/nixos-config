{ pkgs, lib, ... }:
{
  programs = {
    niri.enable = true;
  };

  # options picker
  # `bat $(nix-build --no-out-link '<nixpkgs>' -A xkeyboard_config)/share/X11/xkb/rules/base.lst | fzf`
  services.xserver.xkb = {
    layout = "us,ru";
    options = "ctrl:grouptoggle_capscontrol";
  };
  console.useXkbConfig = lib.mkForce true;

  services = {
    displayManager.gdm.enable = true;
    gnome.gnome-keyring.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
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

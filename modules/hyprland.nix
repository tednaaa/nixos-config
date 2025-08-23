{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Optional, hint electron apps to use wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprlock
    hyprshot

    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk

    pulseaudio # to use pactl
    brightnessctl
    waybar
    swaynotificationcenter
    rofi

    kdePackages.dolphin
    mpv
    clipse
    bluetui
    pavucontrol
    p7zip
  ];

  services.power-profiles-daemon.enable = true;
}

{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Optional, hint electron apps to use wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    hyprpaper hyprlock hyprshot

    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk

    pulseaudio # to use pactl
    brightnessctl
    waybar
    libnotify
    swaynotificationcenter
    rofi

    kdePackages.dolphin
    mpv
    clipse
    bluetui
    pavucontrol
    p7zip
    wl-clipboard
    apple-cursor papirus-icon-theme orchis-theme
  ];

  services.power-profiles-daemon.enable = true;
}

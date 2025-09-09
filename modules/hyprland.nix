{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Optional, hint electron apps to use wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    hyprpaper hyprlock
    xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
    pulseaudio pavucontrol brightnessctl
    libnotify swaynotificationcenter
    waybar rofi satty grim slurp
    apple-cursor papirus-icon-theme orchis-theme
    mpv clipse bluetui p7zip  wl-clipboard

    kdePackages.dolphin
  ];

  services.power-profiles-daemon.enable = true;
}

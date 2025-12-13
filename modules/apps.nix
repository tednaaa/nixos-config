{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obs-studio
    telegram-desktop

    firefox
    google-chrome
  ];
}

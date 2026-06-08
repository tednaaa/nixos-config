{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    obsidian

    obs-studio
    telegram-desktop

    firefox
    google-chrome
  ];
}

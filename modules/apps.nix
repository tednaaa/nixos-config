{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  environment.systemPackages = with pkgs; [
    obsidian

    obs-studio
    telegram-desktop

    firefox
    google-chrome
  ];
}

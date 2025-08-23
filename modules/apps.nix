{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    obs-studio telegram-desktop

    firefox google-chrome

    zed-editor dbeaver-bin playwright-test

    mise uv
  ];
}

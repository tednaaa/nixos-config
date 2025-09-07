{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    alacritty zellij starship neovim

    btop ripgrep zoxide eza fd bat fzf jq
    yazi ueberzugpp resvg tabiew

    git delta lazygit

    netcat-openbsd openssh rsync bind cmake

    docker docker-compose lazydocker

    kubectl kubernetes-helm k9s

    doctl ansible terraform

    nixd
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}

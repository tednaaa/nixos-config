{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zellij neovim
    btop ripgrep zoxide eza fd bat fzf jq
    yazi ueberzugpp resvg tabiew
    git delta lazygit
    netcat-openbsd openssh rsync bind cmake
    docker docker-compose lazydocker
    kubectl kubernetes-helm k9s doctl ansible terraform
    mise uv pnpm
    nixd
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}

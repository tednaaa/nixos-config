{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zellij neovim starship fastfetch
    tabiew btop
    yazi ueberzugpp resvg
    fzf jq ripgrep zoxide eza fd bat
    git delta lazygit
    netcat-openbsd openssh rsync bind cmake
    docker docker-compose lazydocker
    doctl glab kubectl kubernetes-helm k9s ansible opentofu fluxcd
    mise uv pnpm

    # LSP
    nixd nil gitlab-ci-ls
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}

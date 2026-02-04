{ pkgs, ... }:
{
  # run dynamically linked executables, need for zed
  programs.nix-ld = {
    enable = true;
    # libraries = pkgs.steam-run.args.multiPkgs pkgs;
    libraries = [ ];
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    zed-editor
    neovim
    cursor-cli
    claude-code-bin
    # code-cursor
    # opencode

    godot

    zellij
    starship
    fastfetch
    postgresql_18
    dbeaver-bin
    dbgate
    tabiew
    yazi
    ueberzugpp
    resvg

    fzf
    skim
    jq
    ripgrep
    zoxide
    eza
    fd
    bat
    git
    delta
    lazygit
    (callPackage ../packages/resto.nix { })

    # TODO: not working, glibc version is not compatible
    # netcat-openbsd
    openssh
    rsync
    bind
    cmake

    docker-buildx
    docker-compose
    lazydocker

    doctl
    glab
    kubectl
    kubernetes-helm
    k9s
    ansible
    opentofu
    fluxcd

    devenv
    uv
    pnpm

    # LSP
    nixd
    nil
    nginx-language-server
    # gitlab-ci-ls
  ];
}

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
    helix
    neovim

    claude-code
    # sox
    # opencode
    # cursor-cli
    # code-cursor

    # godot

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
    zrok

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
    nodejs

    # Language servers + formatters
    nixd
    nixfmt
    nginx-language-server
    gitlab-ci-ls

    basedpyright # python LSP
    black # python formatter
    typescript-language-server # typescript/javascript LSP (helix default)
    vue-language-server # vue LSP (provides `vue-language-server`)
    vscode-langservers-extracted # provides vscode-eslint-language-server, json/css/html
    yaml-language-server # yaml LSP
  ];
}

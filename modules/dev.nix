{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zed-editor
    neovim
    # godot

    claude-code
    opencode

    zellij
    starship
    fastfetch
    tabiew
    yazi
    resvg

    postgresql_18
    dbeaver-bin
    dbgate

    fzf
    skim
    jq
    ripgrep
    zoxide
    eza
    fd
    dust
    bat
    git
    delta
    lazygit
    (callPackage ../packages/relkit.nix { })
    (callPackage ../packages/resto.nix { })
    (callPackage ../packages/playwright-mcp.nix { })

    netcat-openbsd
    openssh
    rsync
    bind
    cmake
    # zrok

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

    # LSP
    nixd
    nginx-language-server
    basedpyright
    gitlab-ci-ls

    # formatters
    nixfmt
    black
  ];
}

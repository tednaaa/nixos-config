{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    zed-editor
    neovim

    claude-code
    opencode
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
    resvg
    dust

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

    netcat-openbsd
    openssh
    rsync
    bind
    cmake
    # zrok

    nmap
    sqlmap
    seclists
    ffuf
    # feroxbuster
    nuclei
    wireshark
    thc-hydra
    metasploit
    httpx
    burpsuite

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

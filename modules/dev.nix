{ pkgs, ... }:
{
  environment.sessionVariables.AGENT_BROWSER_EXECUTABLE_PATH = "/run/current-system/sw/bin/google-chrome-stable";

  environment.systemPackages = with pkgs; [
    zed-editor
    neovim
    # godot

    herdr
    claude-code
    # opencode
    agent-browser

    zellij
    starship
    fastfetch
    tabiew
    yazi
    resvg

    postgresql_18
    dbeaver-bin
    dbgate

    ffmpeg
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
    gitleaks

    (callPackage ../packages/relkit.nix { })
    (callPackage ../packages/resto.nix { })

    netcat-openbsd
    openssh
    openssl
    rsync
    bind
    cmake
    # zrok

    glab
    ansible
    opentofu
    teleport.client
    # kubectl
    # k9s
    # fluxcd
    # kubernetes-helm

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

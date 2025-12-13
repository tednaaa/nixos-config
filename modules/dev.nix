{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zed-editor neovim
    zellij starship fastfetch
    dbeaver-bin dbgate
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
    playwright-test
  ];
  
  # run dynamically linked executables, need for zed
  programs.nix-ld = {
    enable = true;
    # libraries = pkgs.steam-run.args.multiPkgs pkgs;
    libraries = [];
  };
  
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}

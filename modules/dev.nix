{ pkgs, pkgs-unstable, ... }:
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

  environment.systemPackages =
    (with pkgs; [
      openssh
      rsync
      bind
      cmake
      zrok
      (callPackage ../packages/resto.nix { })
    ])
    ++ (with pkgs-unstable; [
      zed-editor
      neovim
      cursor-cli
      claude-code-bin

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

      devenv
      uv
      pnpm

      nixd
      nixfmt
      nginx-language-server
      gitlab-ci-ls

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
    ]);
}

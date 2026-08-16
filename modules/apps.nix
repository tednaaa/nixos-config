{ pkgs, ... }:
{
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # run dynamically linked executables, need for zed
  programs.nix-ld = {
    enable = true;
    # libraries = pkgs.steam-run.args.multiPkgs pkgs;
    libraries = [ ];
  };

  # right-click game → Properties → Launch Options - do that for all games
  # `gamemoderun %command%`   |or|   `SteamDeck=1 gamemoderun %command%`
  programs = {
    gamemode.enable = true;
    steam.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # obsidian

    obs-studio
    telegram-desktop

    firefox
    google-chrome

    # (callPackage ../packages/elyprismlauncher.nix { })
  ];
}

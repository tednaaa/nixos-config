{ pkgs, ... }:
{
  # right-click game → Properties → Launch Options - do that for all games
  # `gamemoderun %command%`   |or|   `SteamDeck=1 gamemoderun %command%`
  programs = {
    gamemode.enable = true;
    steam.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # for minecraft
    jdk21

    # (callPackage ../packages/elyprismlauncher.nix { })
  ];
}

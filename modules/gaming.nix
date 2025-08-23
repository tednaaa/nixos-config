{ pkgs, ... }: {
  programs.steam.enable = true;

  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
}

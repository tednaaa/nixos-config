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

  environment.systemPackages = with pkgs; [
    # obsidian

    obs-studio
    telegram-desktop

    firefox
    google-chrome
  ];
}

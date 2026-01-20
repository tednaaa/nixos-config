{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    # wine packages, support both 32-bit and 64-bit applications
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull

    # https://github.com/ElyPrismLauncher/ElyPrismLauncher
    (prismlauncher.override {
      prismlauncher-unwrapped = prismlauncher-unwrapped.overrideAttrs (old: {
        src = fetchFromGitHub {
          owner = "ElyPrismLauncher";
          repo = "ElyPrismLauncher";
          rev = "10.0.2";
          hash = "sha256-p9gFdiVRQBIVMatq0v1lw+2ggSU3RV42u55O6w44L9E=";
        };

        pname = "elyprismlauncher";
        version = "10.0.2";
      });

      jdks = [ jdk21 ];
      gamemodeSupport = true;
    })
  ];
}

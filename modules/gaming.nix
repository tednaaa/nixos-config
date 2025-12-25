{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    (prismlauncher.override {
      prismlauncher-unwrapped = prismlauncher-unwrapped.overrideAttrs (old: {
        src = fetchFromGitHub {
          owner = "ElyPrismLauncher";
          repo = "ElyPrismLauncher";
          rev = "9.5";
          hash = "sha256-gGG3A/UezlT3Tq8HMo3mJg7CS/vDByEeh1QxId0Qf2s=";
        };

        pname = "elyprismlauncher";
        version = "9.5";
      });

      jdks = [ jdk21 ];
      gamemodeSupport = true;
    })
  ];
}

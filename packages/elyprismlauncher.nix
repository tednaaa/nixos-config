# https://github.com/ElyPrismLauncher/Launcher

{
  prismlauncher,
  prismlauncher-unwrapped,
  fetchFromGitHub,
  jdk17,
  jdk21,
}:

prismlauncher.override {
  prismlauncher-unwrapped = prismlauncher-unwrapped.overrideAttrs (_: rec {
    pname = "elyprismlauncher";
    version = "10.0.2";

    src = fetchFromGitHub {
      owner = "ElyPrismLauncher";
      repo = "ElyPrismLauncher";
      rev = version;
      hash = "sha256-p9gFdiVRQBIVMatq0v1lw+2ggSU3RV42u55O6w44L9E=";
    };
  });

  jdks = [
    jdk17
    jdk21
  ];
  gamemodeSupport = true;
}

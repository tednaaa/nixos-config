{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  makeWrapper,
  installShellFiles,
  versionCheckHook,
  git,
}:

rustPlatform.buildRustPackage rec {
  pname = "relkit";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "tednaaa";
    repo = "relkit";
    rev = "v${version}";
    hash = "sha256-zvSkG6gq+Uhj/QzFF71f4MWTsrSSiVJx60+Oo79Fph4=";
  };

  cargoHash = "sha256-716H5HuSeB5/YSrSp4BU2ieIMrOXp+3NBxtx3MQMiGY=";

  nativeBuildInputs = [
    makeWrapper
    installShellFiles
  ];

  postInstall =
    lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
      installShellCompletion --cmd relkit \
        --bash <($out/bin/relkit --completions bash) \
        --fish <($out/bin/relkit --completions fish) \
        --zsh <($out/bin/relkit --completions zsh)
    ''
    + ''
      wrapProgram $out/bin/relkit --prefix PATH : ${lib.makeBinPath [ git ]}
    '';

  nativeInstallCheckInputs = [ versionCheckHook ];
  doInstallCheck = true;

  meta = with lib; {
    description = "Interactive release tool that bumps the version, writes a changelog, then tags and pushes";
    homepage = "https://github.com/tednaaa/relkit";
    changelog = "https://github.com/tednaaa/relkit/blob/v${version}/CHANGELOG.md";
    license = licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "relkit";
  };
}

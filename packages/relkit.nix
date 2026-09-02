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
  version = "0.5.0";

  src = fetchFromGitHub {
    owner = "tednaaa";
    repo = "relkit";
    rev = "v${version}";
    hash = "sha256-4ORd3wk26yQw7G6Wxgzeh7aJBfwOH3naEfaEKK/Qe54=";
  };

  cargoHash = "sha256-vFeHT6He/cOJfoJ+4ewQZas4v4g9P5COW11+TtQx1Ro=";

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

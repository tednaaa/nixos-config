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
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "tednaaa";
    repo = "relkit";
    rev = "v${version}";
    hash = "sha256-9MNhlLA7yJYo+X4+/SG2JduFTgxGVnphevM7lWwh4nk=";
  };

  cargoHash = "sha256-RGvxWuoPH1zfxeEkWsavTDM+G2EoeUAwFdnTRj7Dt5s=";

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

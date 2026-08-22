{
  lib,
  rustPlatform,
  fetchFromGitHub,
  makeWrapper,
  git,
}:

rustPlatform.buildRustPackage rec {
  pname = "relkit";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "tednaaa";
    repo = "relkit";
    rev = "v${version}";
    hash = "sha256-ostMnNAJoyHQS0GjiJ3hmKNV6VMAjHnQrUUrn5kS10Q=";
  };

  cargoHash = "sha256-SgU1uaALl83wIuJitifR+Rg8THoZr1tJ/F3BsT/gJQ8=";

  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/relkit --prefix PATH : ${lib.makeBinPath [ git ]}
  '';

  meta = with lib; {
    description = "Interactive release tool that bumps the version, writes a changelog, then tags and pushes";
    homepage = "https://github.com/tednaaa/relkit";
    license = licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "relkit";
  };
}

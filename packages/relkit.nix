{
  lib,
  rustPlatform,
  fetchFromGitHub,
  makeWrapper,
  git,
}:

rustPlatform.buildRustPackage rec {
  pname = "relkit";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "tednaaa";
    repo = "relkit";
    rev = "v${version}";
    hash = "sha256-SLXdL4xK3cnwwinkoE2yL52se0pNaNO1tL2Q/kM98BI=";
  };

  cargoHash = "sha256-mbbu0aFRgvWaZ6MGejk74rxNrkrZAAAMV/NmivTKIt4=";

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

{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
}:

rustPlatform.buildRustPackage rec {
  pname = "resto";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "tednaaa";
    repo = "resto";
    rev = "v${version}";
    hash = "sha256-nKopJujwzrn8dW9NAF+VcbPVq3c2k9C10yu2leUT1oA=";
  };

  cargoHash = "sha256-PrYQJVIDPEyi6nD3bxZ8u/6njlKZEBJ8utfD0vYa/Dw=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];

  meta = with lib; {
    description = "TUI HTTP client written in Rust";
    homepage = "https://github.com/tednaaa/resto";
    license = licenses.gpl3Only;
    maintainers = [ ];
    mainProgram = "resto";
  };
}

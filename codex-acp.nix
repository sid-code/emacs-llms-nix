{
  source,

  rustPlatform,

  pkg-config,
  openssl,
}:
rustPlatform.buildRustPackage {
  pname = "codex-acp";
  version = "git";
  src = source;
  cargoHash = "sha256-TD4iADzLIyv65JcaPm1LnvXipSaCRJMF67D/sDa/lBU=";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];
}

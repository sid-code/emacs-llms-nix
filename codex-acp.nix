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
  cargoHash = "sha256-AxKjNFlF/yTAwO1/MePYuLFjy0yQDahsmwTsSpOhthc=";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ];
}

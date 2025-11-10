{
  source,
  buildNpmPackage,
}:
buildNpmPackage {
  pname = "claude-code-acp";
  version = "git";
  src = source;
  npmDepsHash = "sha256-nzP2cMYKoe4S9goIbJ+ocg8bZPY/uCTOm0bLbn4m6Mw=";
}

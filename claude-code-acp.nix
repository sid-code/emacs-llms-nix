{
  source,
  buildNpmPackage,
}:
buildNpmPackage {
  pname = "claude-code-acp";
  version = "git";
  src = source;
  npmDepsHash = "sha256-2ypTVXRNGvkVHUCi9Q4Vs8tag1N5ilmWRFol8iYOUik=";
}

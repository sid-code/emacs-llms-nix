{
  source,
  buildNpmPackage,
}:
buildNpmPackage {
  pname = "claude-code-acp";
  version = "git";
  src = source;
  npmDepsHash = "sha256-uXBRAiua6dafPXTSrntLiAGqkYM7Vy2zbc1yFcUjh9Y=";
}

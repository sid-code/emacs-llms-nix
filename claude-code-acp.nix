{
  source,
  buildNpmPackage,
}:
buildNpmPackage {
  pname = "claude-code-acp";
  version = "git";
  src = source;
  npmDepsHash = "sha256-1a4XVnem5HeEwlj8gGO2Qq5gkoAsL+VJS7zU5MM5ptY=";
}

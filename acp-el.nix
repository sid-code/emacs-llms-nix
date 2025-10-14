{
  emacsPackages,
  source,
}:
emacsPackages.trivialBuild {
  pname = "acp.el";
  version = "git";
  src = source;
}

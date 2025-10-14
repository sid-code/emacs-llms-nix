{ emacsPackages, source }:
emacsPackages.trivialBuild {
  pname = "shell-maker";
  version = "git";
  src = source;
}

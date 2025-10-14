{
  emacsPackages,
  acp-el,
  shell-maker,
  source,
}:
emacsPackages.trivialBuild rec {
  pname = "agent-shell";
  version = "git";
  src = source;

  propagatedUserEnvPkgs = [
    acp-el
    shell-maker
  ];
  buildInputs = propagatedUserEnvPkgs;
}

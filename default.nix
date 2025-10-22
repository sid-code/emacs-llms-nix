{ callPackage, sources }:
rec {
  acp-el = callPackage ./acp-el.nix { source = sources.acp-el; };
  shell-maker = callPackage ./shell-maker.nix { source = sources.shell-maker; };
  agent-shell = callPackage ./agent-shell {
    source = sources.agent-shell;
    inherit acp-el shell-maker;
  };
  codex-acp = callPackage ./codex-acp.nix { source = sources.codex-acp; };
  claude-code-acp = callPackage ./claude-code-acp.nix { source = sources.claude-code-acp; };
}

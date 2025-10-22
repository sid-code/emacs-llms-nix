{
  description = "LLM-related packages for emacs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    shell-maker-source = {
      url = "github:xenodium/shell-maker";
      flake = false;
    };
    acp-el-source = {
      url = "github:xenodium/acp.el";
      flake = false;
    };
    agent-shell-source = {
      url = "github:xenodium/agent-shell";
      flake = false;
    };
    codex-acp-source = {
      url = "github:zed-industries/codex-acp";
      flake = false;
    };
    claude-code-acp-source = {
      url = "github:zed-industries/claude-code-acp";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      sources = with inputs; {
        shell-maker = shell-maker-source;
        acp-el = acp-el-source;
        agent-shell = agent-shell-source;
        codex-acp = codex-acp-source;
        claude-code-acp = claude-code-acp-source;
      };

      mkPackages = { callPackage, ... }: callPackage ./. { inherit sources; };

      supportedSystems = [ "x86_64-linux" ];

      forEachSystem =
        f:
        nixpkgs.lib.genAttrs supportedSystems (
          system:
          f {
            inherit system;
            pkgs = import nixpkgs { inherit system; };
          }
        );
    in
    {
      packages = forEachSystem ({ pkgs, ... }: mkPackages pkgs);
      homeModules = [
        (_: {
          imports = [
            (
              { system, lib, ... }:
              {
                programs.emacs = {
                  overrides = _: _: self.packages.x86_64-linux;
                  agent-shell.providers = {
                    anthropic.acpPackage = lib.mkDefault self.packages.${system}.claude-code-acp;
                    openai.acpPackage = lib.mkDefault self.packages.${system}.codex-acp;
                  };
                };
              }
            )
            ./agent-shell/module.nix
          ];
        })
      ];
    };
}

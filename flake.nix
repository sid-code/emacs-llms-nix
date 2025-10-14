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
  };

  outputs =
    {
      self,
      nixpkgs,
      shell-maker-source,
      acp-el-source,
      agent-shell-source,
      ...
    }:
    let
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
      sources = {
        shell-maker = shell-maker-source;
        acp-el = acp-el-source;
        agent-shell = agent-shell-source;
      };
    in
    {
      packages = forEachSystem ({ pkgs, ... }: pkgs.callPackage ./. { inherit sources; });
      homeModules = [
        (_: {
          imports = [
            (_: {
              programs.emacs.overrides = self.packages.x86_64-linux;
            })
            ./agent-shell/module.nix
          ];
        })
      ];
    };
}

# Home-manager module for agent-shell
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.emacs.agent-shell;
  inherit (lib)
    mkIf
    mkEnableOption
    mkOption
    types
    ;
in
{
  options.programs.emacs.agent-shell = {
    enable = mkEnableOption "emacs agent-shell package";
    # TODO: other providers
    providers =
      let
        provider =
          providerName:
          types.submodule {
            options = {
              enable = mkEnableOption "${providerName} provider";
              apiKeyFile = mkOption {
                description = ''
                  Path to the API key for provider ${providerName}.
                  If not provided, will attempt to use a login flow.
                '';
                type = types.nullOr types.path;
              };
            };
          };
      in
      {
        google = mkOption {
          type = provider "google";
        };
        anthropic = mkOption {
          type = provider "anthropic";
        };
      };
  };
  config = {
    programs.emacs = mkIf cfg.enable {
      extraPackages = epkgs: [
        epkgs.agent-shell
        epkgs.f
      ];
      extraConfig =
        let
          authClause =
            apiKeyFile: if apiKeyFile == null then ":login t" else "(f-read-text \"${apiKeyFile}\")";
          providerAuthVariable = provider: "agent-shell-${provider}-authentication";
          providerMakeAuthFn = provider: "agent-shell-${provider}-make-authentication";
          providerVariableSet =
            provider:
            if cfg.providers.${provider}.enable then
              "(setq ${providerAuthVariable} (${providerMakeAuthFn} ${
                authClause cfg.providers.${provider}.apiKeyFile
              }))"
            else
              "";
        in
        ''
          (use-package agent-shell
            :config
            (require 'f)
            ${providerVariableSet "google"}
            ${providerVariableSet "anthropic"}
            ${providerVariableSet "openai"})
        '';

    };
    home.packages =
      (if cfg.providers.google.enable then [ pkgs.gemini-cli ] else [ ])
      ++ (if cfg.providers.openai.enable then [ pkgs.codex-acp ] else [ ]);
  };
}

# Home-manager module for agent-shell
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.emacs.agent-shell;
  inherit (lib) mkIf mkEnableOption;
in
{
  options.programs.emacs.agent-shell = {
    enable = mkEnableOption "emacs agent-shell package";
    # TODO: other providers
    providers.gemini = {
      enable = mkEnableOption "emacs agent shell gemini support";
    };
  };
  config = {
    programs.emacs = mkIf cfg.enable {
      extraPackages = epkgs: [ epkgs.agent-shell ];
      extraConfig = mkIf cfg.providers.gemini.enable ''
        (use-package agent-shell
          :config
          ;; TODO: other ways to authenticate
          (setq agent-shell-google-authentication
            (agent-shell-google-make-authentication :login t)))
      '';
    };
    home.packages = mkIf cfg.providers.gemini.enable [ pkgs.gemini-cli ];
  };
}

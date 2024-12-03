{
  lib,
  pkgs,
  inputs,
  system,
  namespace,
  config,
  ...
}: {
  options.${namespace}.apps.vscode.enable = lib.mkEnableOption "VSCodium";

  config = lib.mkIf config.${namespace}.apps.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      mutableExtensionsDir = false;
      enableUpdateCheck = false;

      extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
        jnoortheen.nix-ide
        vscode-icons-team.vscode-icons
      ];

      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.formatOnSave" = true;

        "workbench.iconTheme" = "vscode-icons";

        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            formatting.command = ["alejandra"];
          };
        };
      };
    };
  };
}

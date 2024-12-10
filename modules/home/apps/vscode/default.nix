{
  lib,
  pkgs,
  inputs,
  system,
  namespace,
  config,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "VSCodium";
} {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;
    enableUpdateCheck = false;

    # Profiles when home-manager?
    extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
      jnoortheen.nix-ide
      vscode-icons-team.vscode-icons

      # Dart
      dart-code.dart-code
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

      "vsicons.dontShowNewVersionMessage" = true;
    };
  };
}

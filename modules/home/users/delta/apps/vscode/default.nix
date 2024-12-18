{
  lib,
  inputs,
  system,
  namespace,
  config,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific VSCodium config";
} {
  anima = {
    apps = {
      vscode.enable = true;
    };
  };

  programs.vscode = {
    # Profiles when home-manager?
    extensions = with inputs.nix-vscode-extensions.extensions.${system}.vscode-marketplace; [
      jnoortheen.nix-ide
      vscode-icons-team.vscode-icons

      esbenp.prettier-vscode
      tamasfe.even-better-toml
      karunamurti.tera
      uncenter.better-tera

      # HELL ON EARTH
      dart-code.dart-code
      dart-code.flutter

      redhat.java
      redhat.vscode-xml
      redhat.vscode-yaml
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

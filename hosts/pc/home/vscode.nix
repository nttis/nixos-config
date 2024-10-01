{ pkgs, inputs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with inputs.nix-vscode-extensions.extensions."x86_64-linux".vscode-marketplace; [
      jnoortheen.nix-ide
      akamud.vscode-theme-onedark
      vscode-icons-team.vscode-icons
    ];
    userSettings = {
      "security.workspace.trust.enabled" = false;

      "files.autoSave" = "afterDelay";
      "editor.formatOnSave" = true;

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";

      "workbench.colorTheme" = "Atom One Dark";
      "workbench.iconTheme" = "vscode-icons";

      "vsicons.dontShowNewVersionMessage" = true;
    };
  };
}

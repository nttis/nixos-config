# This VSCode is a base VSCode, containing settings and things
# that should always exist regardless of environments/projects
# such as theme, user settings, etc.

{
  pkgs,
  inputs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # Extensions are temporary until the Profiles feature
    # becomes available in home-manager (when?)
    extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      # Theming
      akamud.vscode-theme-onedark
      vscode-icons-team.vscode-icons

      # General
      esbenp.prettier-vscode

      # Nix
      jnoortheen.nix-ide

      # JS
      oven.bun-vscode
      dbaeumer.vscode-eslint
    ];
    userSettings = {
      "security.workspace.trust.enabled" = false;

      "files.autoSave" = "afterDelay";
      "editor.formatOnSave" = true;

      "git.enableSmartCommit" = true;

      # "workbench.colorTheme" = "Atom One Dark";
      "workbench.iconTheme" = "vscode-icons";

      "vsicons.dontShowNewVersionMessage" = true;

      # Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
    };
  };
}

{
  inputs,
  lib,
  pkgs,
  config,
  system,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific Helix config";
} {
  anima = {
    apps = {
      helix.enable = true;
    };
  };

  programs.helix = {
    defaultEditor = true;

    languages = {
      language = [
        {
          name = "nix";
          formatter = {command = "${pkgs.alejandra}/bin/alejandra";};
          auto-format = true;
          language-servers = ["nixd"];
        }

        {
          name = "toml";
          formatter = {command = "${pkgs.taplo}/bin/taplo";};
          auto-format = true;
        }

        {
          name = "qml";
          auto-format = true;
          language-servers = ["qmlls"];
        }
      ];

      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };

        qmlls = {
          command = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls";
          args = [
            "-I"
            "${inputs.quickshell.packages.${system}.default}/lib/qt-6/qml"
            "-I"
            "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"
          ];
        };
      };
    };

    settings = {
      editor.cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
    };
  };
}

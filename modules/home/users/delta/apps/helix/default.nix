{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific Helix config";
} {
  programs.helix = {
    enable = true;
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
      ];

      language-server = {
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
      };
    };

    settings = {
      editor.cursor-shape = {
        insert = "bar";
        normal = "bar";
        select = "underline";
      };
    };
  };
}

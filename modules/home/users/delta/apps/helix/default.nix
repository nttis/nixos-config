{
  inputs,
  lib,
  pkgs,
  config,
  namespace,
  system,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific Helix config";
} {
  home.packages = [
    pkgs.nixd

    pkgs.taplo

    pkgs.vscode-langservers-extracted
    pkgs.typescript-language-server
    pkgs.typescript
    pkgs.superhtml

    pkgs.bash-language-server

    pkgs.zls
  ];

  programs.helix = {
    enable = true;
    defaultEditor = true;

    languages = {
      language = [
        {
          name = "nix";
          formatter = {command = "${pkgs.alejandra}/bin/alejandra";};
          auto-format = true;
        }

        {
          name = "toml";
          formatter = {
            command = "${pkgs.taplo}/bin/taplo";
            args = ["fmt" "-"];
          };
          auto-format = true;
        }

        {
          name = "html";
          language-servers = ["vscode-html-language-server" "superhtml"];
          auto-format = true;
        }

        {
          name = "typst";
          language-servers = ["tinymist"];
          auto-format = true;
        }

        {
          name = "zig";
          formatter = {
            command = "${inputs.zig.packages.${system}.master}/bin/zig";
            args = ["fmt" "--stdin"];
          };
          auto-format = true;
        }
      ];

      language-server = {
        # typst-ls is already deprecated lol...
        tinymist = {
          command = "${pkgs.tinymist}/bin/tinymist";
        };
      };
    };

    settings = {
      theme = "onedark";

      editor = {
        shell = ["${pkgs.nushell}/bin/nu" "-c"];
        cursorline = true;
        default-yank-register = "+";
        end-of-line-diagnostics = "hint";
        auto-format = true;
        preview-completion-insert = true;
        completion-replace = true;
        true-color = true;
        color-modes = true;
        rulers = [120];
        text-width = 100;
      };

      editor.lsp = {
        display-inlay-hints = true;
      };

      editor.file-picker = {
        hidden = false;
      };

      editor.auto-pairs = true;

      editor.auto-save = {
        focus-lost = true;
        after-delay.enable = true;
        after-delay.timeout = 500;
      };

      editor.indent-guides = {
        render = true;
        character = "┆";
      };

      editor.inline-diagnostics = {
        cursor-line = "warning";
      };

      editor.statusline = {
        right = ["diagnostics" "register" "position" "file-encoding" "version-control"];
      };

      editor.cursor-shape = {
        insert = "bar";
        normal = "bar";
        select = "underline";
      };

      keys = {
        normal = {
          A-x = "extend_to_line_bounds";
          X = "select_line_above";
        };
        select = {
          A-x = "extend_to_line_bounds";
          X = "select_line_above";
        };
      };
    };
  };
}

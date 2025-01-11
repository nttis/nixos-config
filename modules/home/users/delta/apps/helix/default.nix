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

    # Wraps Helix to expose language-support executables to its PATH
    # instead of having to manually reconfigure each LSP by hand
    package = pkgs.stdenvNoCC.mkDerivation {
      name = "helix-wrapper";
      phases = ["installPhase"];

      nativeBuildInputs = [
        pkgs.makeWrapper
      ];

      installPhase = let
        pathStr = builtins.concatStringsSep ":" [
          # Nix
          "${pkgs.nixd}/bin"

          # TOML
          "${pkgs.taplo}/bin"

          # JS, TS, CSS, HTML, JSON
          "${pkgs.vscode-langservers-extracted}/bin"
          "${pkgs.typescript}/bin"
          "${pkgs.typescript-language-server}/bin"
          "${pkgs.superhtml}/bin"

          # Bash (self-explanatory lmao)
          "${pkgs.bash-language-server}/bin"

          # Markdown
          "${pkgs.marksman}/bin"

          # Zig
          "${pkgs.zls}/bin"
          "${pkgs.zig}/bin"
        ];
      in
        /*
        bash
        */
        ''
          mkdir -p $out
          cp -r ${pkgs.helix}/* $out
          chmod -R 755 $out

          wrapProgram $out/bin/hx \
            --set PATH ${pathStr}
        '';
    };

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
            command = "${pkgs.zig}/bin/zig";
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
      editor = {
        shell = ["${pkgs.nushell}/bin/nu" "-c"];
        cursorline = true;
        end-of-line-diagnostics = "hint";
        auto-format = true;
        preview-completion-insert = false;
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

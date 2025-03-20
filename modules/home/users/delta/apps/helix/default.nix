{
  inputs,
  lib,
  pkgs,
  config,
  namespace,
  system,
  host,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific Helix config";
} {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = [
      pkgs.nixd

      pkgs.taplo

      pkgs.vscode-langservers-extracted
      pkgs.typescript-language-server
      pkgs.typescript
      pkgs.superhtml

      pkgs.bash-language-server

      pkgs.tinymist

      pkgs.zls
    ];

    languages = {
      language = [
        {
          name = "nix";
          formatter = {command = "${pkgs.alejandra}/bin/alejandra";};
        }

        {
          name = "toml";
          formatter = {
            command = "${pkgs.taplo}/bin/taplo";
            args = ["fmt" "-"];
          };
        }

        {
          name = "html";
          language-servers = ["vscode-html-language-server" "superhtml"];
        }

        {
          name = "typst";
          language-servers = ["tinymist"];
        }

        {
          name = "zig";
          formatter = {
            command = "${pkgs.zig}/bin/zig";
            args = ["fmt" "--stdin"];
          };
        }
      ];

      language-server = {
        # typst-ls is already deprecated lol...
        tinymist = {
          command = "tinymist";
        };

        nixd = let
          flakeRef = lib.snowfall.fs.get-file ".";

          nixdConfig = builtins.toJSON {
            nixd = {
              options = {
                nixos.expr = ''
                  (builtins.getFlake "${flakeRef}").nixosConfigurations.${host}.options
                '';

                home-manager.expr = ''
                  (builtins.getFlake "${flakeRef}").homeConfigurations."${config.snowfallorg.user.name}@${host}".options
                '';
              };
            };
          };
        in {
          command = "nixd";

          args = [
            "--inlay-hints"
            "--config=${nixdConfig}"
          ];
        };
      };
    };

    settings = {
      theme = lib.mkDefault "onedark";

      editor = {
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

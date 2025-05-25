{
  lib,
  pkgs,
  osConfig,
  self,
  ...
}: {
  imports = [];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = [
      pkgs.nixd
      pkgs.alejandra

      pkgs.taplo

      pkgs.vscode-langservers-extracted
      pkgs.typescript-language-server
      pkgs.typescript

      pkgs.bash-language-server

      pkgs.marksman
      pkgs.tinymist

      pkgs.zig
      pkgs.zls

      pkgs.gotools
      pkgs.gopls

      pkgs.luau-lsp
      pkgs.stylua
    ];

    languages = {
      language = [
        {
          name = "nix";
          formatter = {command = "alejandra";};
        }

        {
          name = "go";
          formatter = {command = "goimports";};
        }

        {
          name = "toml";
          formatter = {
            command = "taplo";
            args = ["fmt" "-"];
          };
        }

        {
          name = "html";
          language-servers = ["vscode-html-language-server"];
        }

        {
          name = "typst";
          language-servers = ["tinymist"];
        }

        {
          name = "zig";
          formatter = {
            command = "zig";
            args = ["fmt" "--stdin"];
          };
        }

        {
          name = "ziggy";
          scope = "text.ziggy";
          roots = [];
          injection-regex = "ziggy|zgy";
          file-types = ["ziggy" "zgy"];
          comment-token = "//";
          auto-format = true;
          formatter = {
            command = "ziggy";
            args = ["fmt" "--stdin"];
          };
          language-servers = ["ziggy-lsp"];
        }

        {
          name = "asciidoc";
          scope = "source.adoc";
          injection-regex = "adoc";
          file-types = ["adoc"];
          comment-tokens = ["//"];
          block-comment-tokens = [
            {
              start = "////";
              end = "////";
            }
          ];
        }

        {
          name = "luau";
          scope = "source.luau";
          injection-regex = "^luau$";
          file-types = ["luau"];
          comment-tokens = ["--" "---"];
          block-comment-tokens = [
            {
              start = "--[[";
              end = "]]";
            }
            {
              start = "--[=[";
              end = "]=]";
            }
            {
              start = "--[==[";
              end = "]==]";
            }
          ];
          roots = ["default.project.json" "wally.toml"];
          language-servers = ["luau-lsp"];
          formatter = {command = "stylua";};
        }
      ];

      language-server = {
        luau-lsp = {
          command = "luau-lsp";
          args = ["lsp"];
        };

        # typst-ls is already deprecated lol...
        tinymist = {
          command = "tinymist";
        };

        nixd = let
          options = ''
            (builtins.getFlake "${self}").nixosConfigurations.${osConfig.networking.hostName}.options
          '';
        in {
          command = "nixd";

          config.nixd.options = {
            nixos.expr = options;
            home-manager.expr = options + ".home-manager.users.type.getSubOptions []";
          };

          args = [
            "--inlay-hints"
          ];
        };
      };
    };

    settings = {
      # theme = lib.mkForce "onedark";

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

  # asciidoc
  xdg.configFile."helix/runtime/queries/asciidoc" = {
    source = "${pkgs.tree-sitter-asciidoc}/queries";
    recursive = true;
  };

  xdg.configFile."helix/runtime/grammars/asciidoc.so" = {
    source = "${pkgs.tree-sitter-asciidoc}/parser";
  };

  # ziggy
  xdg.configFile."helix/runtime/grammars/ziggy.so" = {
    source = "${pkgs.tree-sitter-ziggy}/parser";
  };

  xdg.configFile."helix/runtime/queries/ziggy" = {
    source = "${pkgs.tree-sitter-ziggy}/queries";
    recursive = true;
  };

  # luau
  xdg.configFile."helix/runtime/grammars/luau.so" = {
    source = "${pkgs.tree-sitter-luau}/parser";
  };

  xdg.configFile."helix/runtime/queries/luau" = {
    source = "${pkgs.tree-sitter-luau}/queries";
    recursive = true;
  };
}

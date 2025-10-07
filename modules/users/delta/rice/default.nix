{ ... }:
{
  flake.modules.homeManager."rice@delta" =
    {
      pkgs,
      ...
    }:
    let
      matugenWrapper = pkgs.writeShellApplication {
        name = "matugen-wrapper";
        runtimeInputs = [ pkgs.matugen ];

        text = ''
          matugen -c ${./matugen}/matugen.toml "$@"
        '';
      };
    in
    {
      imports = [ ];

      fonts.fontconfig = {
        enable = true;
        antialiasing = true;
        hinting = "slight";

        defaultFonts = {
          sansSerif = [ "Noto Sans" ];
          serif = [ "Noto Serif" ];
          monospace = [ "0xProto Nerd Font" ];
        };
      };

      gtk = {
        enable = true;

        iconTheme = {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
        };

        theme = {
          package = pkgs.gnome-themes-extra;
          name = "Adwaita";
        };

        gtk3.extraCss = ''@import "colors.css";'';
        gtk4.extraCss = ''@import "colors.css";'';
      };

      qt = {
        enable = true;
        platformTheme.name = "qtct";
      };

      xdg.configFile = {
        "qt5ct/qt5ct.conf" = {
          enable = true;
          text = ''
            [Appearance]
            color_scheme_path=~/.config/qt5ct/colors/matugen.conf
            custom_palette=true
          '';
        };

        "qt6ct/qt6ct.conf" = {
          enable = true;
          text = ''
            [Appearance]
            color_scheme_path=~/.config/qt6ct/colors/matugen.conf
            custom_palette=true
          '';
        };
      };

      home.pointerCursor = {
        enable = true;

        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 28;

        gtk.enable = true;
        x11.enable = true;
        hyprcursor.enable = true;
      };

      programs.kitty.extraConfig = ''
        include colors.conf
      '';

      systemd.user.services = {
        run-matugen = {
          Unit = {
            Description = "Run matugen on login";
          };

          Service = {
            Type = "exec";
            ExecStart = "${pkgs.lib.getExe matugenWrapper} color hex 0a0 --type scheme-fidelity";
            RemainAfterExit = true;
          };

          Install = {
            WantedBy = [ "graphical-session.target" ];
          };
        };
      };

      home.packages = [ matugenWrapper ];
    };
}

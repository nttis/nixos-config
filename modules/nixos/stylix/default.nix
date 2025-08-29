{ pkgs, ... }:
{
  imports = [ ];

  stylix = {
    enable = true;
    enableReleaseChecks = false;
    autoEnable = false;

    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";

    image = null;

    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 28;
    };

    fonts = {
      serif = {
        name = "Noto Serif";
        package = pkgs.noto-fonts;
      };
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };
      monospace = {
        name = "0xProto Nerd Font";
        package = pkgs.nerd-fonts._0xproto;
      };
      emoji = {
        name = "Noto Emoji";
        package = pkgs.noto-fonts-emoji;
      };
    };
  };

  stylix.targets = {
    console.enable = true;
  };

  home-manager.sharedModules = [
    {
      stylix.iconTheme = {
        enable = true;
        package = pkgs.papirus-icon-theme;
        dark = "Papirus-Dark";
        light = "Papirus-Light";
      };

      stylix.targets = {
        kitty.enable = true;
        fish.enable = true;
        font-packages.enable = true;
        fontconfig.enable = true;
        yazi.enable = true;
        waybar.enable = true;

        gtk = {
          enable = true;
          flatpakSupport.enable = true;
        };
      };
    }
  ];
}

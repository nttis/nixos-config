{ self, ... }:
{
  flake.modules.nixos.daily-drive =
    { pkgs, ... }:
    {
      imports = [
        self.modules.nixos.scanners
        self.modules.nixos.printing
      ];

      hardware = {
        enableRedistributableFirmware = true;
        graphics.enable = true;
      };

      security = {
        polkit.enable = true;
        rtkit.enable = true;
      };

      services = {
        upower = {
          enable = true;
          noPollBatteries = true;
        };

        gvfs.enable = true;

        pipewire = {
          enable = true;
          audio.enable = true;
          pulse.enable = true;
          wireplumber.enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
        };

        flatpak.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };

      fonts = {
        packages = with pkgs; [
          noto-fonts
          noto-fonts-color-emoji
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif

          material-symbols
          roboto

          nerd-fonts._0xproto
        ];
      };


      environment = {
        systemPackages = with pkgs; [
          helix
          kitty
          yazi
          trashy
          libarchive
          aria2
          brightnessctl
          wireplumber
          pwvucontrol
          qpwgraph
        ];

        shellAliases = {
          rm = ''echo "rm is aliased away, use 'trash' instead"; false'';
        };

        sessionVariables = {
          EDITOR = "hx";
        };
      };
    };
}

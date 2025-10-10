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

        gpm.enable = true;
      };

      fonts = {
        packages = with pkgs; [
          noto-fonts
          noto-fonts-color-emoji
          noto-fonts-extra
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif

          material-symbols
          roboto

          nerd-fonts._0xproto
        ];
      };

      system.replaceDependencies.replacements = [
        {
          oldDependency = pkgs.xdg-utils;
          newDependency = pkgs.xdg-utils.overrideAttrs (prev: {
            postFixup =
              let
                handlr-script = pkgs.writeShellScript "xdg-open" ''
                  ${pkgs.lib.getExe pkgs.handlr-regex} open "$@"
                '';
              in
              ''
                cp ${handlr-script} $out/bin/xdg-open
              '';
          });
        }
      ];

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

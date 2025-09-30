{ pkgs, ... }:
{
  imports = [ ];

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

    udisks2.enable = true;
    devmon.enable = true;

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
}

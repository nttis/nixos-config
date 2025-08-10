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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  services = {
    flatpak.enable = true;

    upower = {
      enable = true;
      noPollBatteries = true;
    };

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
      libarchive
      aria2
      wl-clipboard
      rofi-wayland
      brightnessctl
      wireplumber
      pwvucontrol
    ];

    sessionVariables = {
      EDITOR = "hx";
    };
  };
}

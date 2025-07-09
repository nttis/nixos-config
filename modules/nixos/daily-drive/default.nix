{
  pkgs,
  perSystem,
  ...
}: {
  imports = [];

  programs = {
    niri = {
      enable = true;
      # package = perSystem.niri.default;
    };

    dconf.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
    graphics.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
        user = "greeter";
      };
    };
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
  };

  services.flatpak.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
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

  environment = {
    systemPackages = with pkgs; [
      helix
      kitty
      libarchive
      aria2
      wl-clipboard
      rofi-wayland
      brightnessctl
      wireplumber

      # perSystem.xwayland-satellite.default
    ];

    sessionVariables = {
      EDITOR = "hx";
    };
  };
}

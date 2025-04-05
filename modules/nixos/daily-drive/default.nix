{pkgs, ...}: {
  imports = [];

  programs = {
    xwayland.enable = true;
    niri.enable = true;
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

  xdg.portal.xdgOpenUsePortal = true;

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

      nerd-fonts.fira-code
    ];
  };

  environment.systemPackages = with pkgs; [
    helix
    kitty
    libarchive

    wl-clipboard
    rofi-wayland
    brightnessctl
    wireplumber
  ];

  environment.variables = {
    DISPLAY = ":0";
  };
}

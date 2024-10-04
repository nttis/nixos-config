{
  pkgs,
  inputs,
  ...
}:
let
  rootPath = ./../..;
in

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.ags.homeManagerModules.default

    (rootPath + /modules/home)
  ];

  impermanence.enable = true;
  hyprland.enable = true;

  home.username = "delta";
  home.homeDirectory = "/home/delta";

  home.sessionVariables = {
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
    NIX_PATH = "/persist/nixos";
  };

  home.packages = with pkgs; [
    # Desktop apps
    vlc
    mpv
    sublime
    vesktop
    gparted

    # Terminal
    fish

    # CLIs
    ffmpeg-full
    fastfetch

    # Development
    nixd
    nixfmt-rfc-style

    inputs.ags.packages.${pkgs.system}.astal

    # Misc
    hicolor-icon-theme
    yaru-theme
  ];

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
  };

  programs.ags = {
    enable = true;
    configDir = ../../ags;

    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.wireplumber
      inputs.ags.packages.${pkgs.system}.bluetooth

      fzf
      dart-sass
    ];
  };

  home.stateVersion = "24.05";
}

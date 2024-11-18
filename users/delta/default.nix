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
    inputs.nixcord.homeManagerModules.nixcord

    (rootPath + /modules/home)
  ];

  impermanence.enable = true;

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
    gparted

    # CLIs
    ffmpeg-full
    fastfetch
    p7zip

    (pkgs.callPackage (rootPath + /packages/heimdall.nix) { })
    android-tools
    avbroot

    # Development
    nixd
    nixfmt-rfc-style

    inputs.ags.packages.${pkgs.system}.astal4

    # Misc
    hicolor-icon-theme
    cbonsai
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

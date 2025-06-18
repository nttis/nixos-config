{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
    inputs.nix-flatpak.homeManagerModules.nix-flatpak

    ./helix.nix
    ./git.nix
    ./waybar.nix
    ./terminal.nix
    ./swww.nix
    ./keepassxc.nix
    ./easyeffects.nix
    ./firefox/default.nix
    ./gpg/default.nix
    ./i18n/default.nix
  ];

  services = {
    dunst.enable = true;
  };

  services.flatpak = {
    enable = true;

    packages = [
      "org.vinegarhq.Sober"
      "org.vinegarhq.Vinegar"
    ];
  };

  xdg.configFile."niri/config.kdl" = {
    enable = true;
    force = true;
    source = ./niri/config.kdl;
  };

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Dark";
  };

  home.packages = [
    pkgs.onlyoffice-desktopeditors
    pkgs.xwayland-satellite
    pkgs.localsend
    pkgs.kdePackages.kleopatra
  ];

  home.persistence."/persist/delta" = lib.mkIf osConfig.impermanence.enable {
    directories = [
      "Downloads"

      ".gnupg/private-keys-v1.d"

      # Flatpak stuff
      ".local/share/flatpak"
      ".var/app"
    ];

    allowOther = true;
  };

  home.stateVersion = "24.05";
}

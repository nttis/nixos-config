{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence

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

  services.podman = {
    enable = true;
  };

  xdg.configFile."niri/config.kdl" = {
    enable = true;
    force = true;
    source = ./niri/config.kdl;
  };

  home.packages = [
    pkgs.onlyoffice-desktopeditors
    pkgs.localsend
    pkgs.kdePackages.kleopatra
    pkgs.ghc
  ];

  home.persistence."/persist/delta" = {
    directories = [
      "Downloads"

      # Nix eval cache to help with eval times through reboots
      ".cache/nix/eval-cache-v5"

      # GPG keys
      ".gnupg/private-keys-v1.d"

      # Flatpak stuff
      ".local/share/flatpak"
      ".var/app"
    ];

    allowOther = true;
  };

  home.stateVersion = "24.05";
}

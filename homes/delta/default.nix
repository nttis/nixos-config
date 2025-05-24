{
  inputs,
  lib,
  pkgs,
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
    ./firefox

    ./i18n/default.nix
  ];

  services = {
    dunst.enable = true;
    ssh-agent.enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
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
    source = ./niri/config.kdl;
  };

  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Start xwayland-satellite";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "always";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  gtk.iconTheme = {
    package = pkgs.papirus-icon-theme;
    name = "Papirus-Light";
  };

  home.packages = [
    pkgs.onlyoffice-desktopeditors
    pkgs.localsend
    pkgs.bottom
  ];

  home.persistence."/persist/delta" = lib.mkIf osConfig.impermanence.enable {
    directories = [
      "Downloads"

      ".ssh"

      # Flatpak stuff
      ".local/share/flatpak"
      ".var/app"
    ];

    allowOther = true;
  };

  home.stateVersion = "24.05";
}

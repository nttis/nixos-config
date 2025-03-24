{
  lib,
  pkgs,
  systemOptions,
  ...
}: {
  imports = [
    ./helix.nix
    ./git.nix
    ./librewolf.nix
    ./waybar.nix
    ./terminal.nix
  ];

  services = {
    dunst.enable = true;
    network-manager-applet.enable = true;
  };

  services.ssh-agent = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    compression = true;
  };

  home.packages = [
    pkgs.libreoffice
  ];

  xdg.configFile."niri/config.kdl" = {
    enable = true;
    source = ./niri/config.kdl;
  };

  home.persistence."/persist/delta" = lib.mkIf systemOptions.impermanence.enable {
    directories = [
      "Downloads"

      ".ssh"
    ];

    allowOther = true;
  };

  home.stateVersion = "24.05";
}

{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence

    ./firefox.nix
    ./vscode.nix
    ./kitty.nix
    ./git.nix
  ];

  home.username = "delta";
  home.homeDirectory = "/home/delta";

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  home.packages = with pkgs; [
    # Desktop apps
    vlc
    mpv
    sublime
    vesktop
    gparted

    # Terminal
    kitty
    fish

    # CLIs
    ffmpeg-full
    neofetch

    # Development tools
    nixd
    nixfmt-rfc-style
  ];

  # Impermanence stuff
  home.persistence."/persist/delta" = {
    directories = [
      ".ssh"
      ".gnupg"

      ".local/share/keyrings"
      ".local/share/direnv"

      ".local/share/flatpak"
      ".var"

      ".config/vesktop"

      ".mozilla"
    ];
    allowOther = true;
  };

  home.stateVersion = "24.05";
}

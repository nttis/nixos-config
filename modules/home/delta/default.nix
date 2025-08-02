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

    ./niri
    ./firefox
    ./gpg
    ./i18n
  ];

  services = {
    dunst.enable = true;
    podman.enable = true;
  };

  systemd.user.services.mic-volume = {
    Unit = {
      Description = "Lower microphone volume";
      After = ["graphical-session.target" "wireplumber.target"];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 30%";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target" "wireplumber.target"];
    };
  };

  home.packages = with pkgs; [
    onlyoffice-desktopeditors
    kdePackages.kleopatra
    ghc
  ];

  home.persistence."/persist/delta" = {
    directories = [
      "Downloads"

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

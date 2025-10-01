{
  inputs,
  lib,
  pkgs,
  options,
  ...
}:
{
  imports = [
    inputs.impermanence.homeManagerModules.impermanence

    ./helix.nix
    ./git.nix
    ./terminal.nix
    ./swww.nix
    ./keepassxc.nix
    ./mimetypes.nix

    ./rice
    ./niri
    ./firefox
    ./gpg
    ./i18n
  ];

  services = {
    dunst.enable = true;
    podman.enable = true;
    udiskie.enable = true;
  };

  systemd.user.services.mic-volume = {
    Unit = {
      Description = "Lower microphone volume";
      After = [
        "graphical-session.target"
        "wireplumber.target"
      ];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 30%";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [
        "graphical-session.target"
        "wireplumber.target"
      ];
    };
  };

  home = lib.mkMerge [
    {
      packages = with pkgs; [
        libreoffice
      ];

      stateVersion = "24.05";
    }

    (lib.optionalAttrs (options ? home.persistence) {
      persistence."/persist/delta" = {
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
    })
  ];
}

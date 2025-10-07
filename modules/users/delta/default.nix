{ self, inputs, ... }:
let
  name = "delta";
in
{
  flake.modules.nixos."users.${name}" =
    { config, ... }:
    {
      imports = with self.modules.nixos; [
        uinput
        home-manager
      ];

      users.users.${name} = {
        hashedPassword = "$y$j9T$xL4SLWPnBD84BSCranVgE/$RltD31LVzUEpqWONk01QUQKzcEZj0F7D2Ephjns4BLB";
        isNormalUser = true;
        extraGroups = [
          "wheel"
          (config.users.groups.input.name)
          (config.users.groups.uinput.name)
        ];
      };

      home-manager.users.${name} = {
        imports = [ self.modules.homeManager."users.${name}" ];
      };
    };

  flake.modules.homeManager."users.${name}" =
    { lib, pkgs, ... }:
    {
      imports =
        lib.map (x: self.modules.homeManager."${x}@${name}") [
          "firefox"
          "fcitx5"
          "helix"
          "git"
          "terminal"
          "swww"
          "keepassxc"
          "mimetypes"
          "rice"
          "niri"
          "gpg"
        ]
        ++ [ inputs.nix-index-database.homeModules.nix-index ];

      services = {
        dunst.enable = true;
        udiskie.enable = true;
      };

      home.packages = [
        pkgs.onlyoffice-bin
      ];

      home.stateVersion = "24.05";
    };

  flake.modules.homeManager.impermanence = {
    home.persistence."/persist/${name}" = {
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
  };
}

{ lib, ... }:
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";

  hardware.graphics.enable = true;
  hardware.enableAllFirmware = true;
  hardware.bluetooth.powerOnBoot = false;

  # Services
  services = {
    printing.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    openssh.enable = true;

    flatpak = {
      enable = true;
      remotes = lib.mkOptionDefault [ ];
      packages = [ ];
    };
  };

  users.mutableUsers = false;
}

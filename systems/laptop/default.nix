{self, ...}: {
  imports = [
    ./hardware-configuration.nix

    "${self}/modules/foundation"
    "${self}/modules/daily-drive"
    "${self}/modules/impermanence"
    "${self}/modules/power"
    "${self}/modules/networking"
    "${self}/modules/daily-drive"
    "${self}/modules/stylix"

    "${self}/modules/users/delta"
  ];

  impermanence.enable = true;

  networking.hostName = "laptop"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";
}

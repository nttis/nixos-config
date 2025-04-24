{self, ...}: {
  imports = [
    ./hardware-configuration.nix

    "${self}/modules/foundation"
    "${self}/modules/daily-drive"
    "${self}/modules/impermanence"
    "${self}/modules/networking"
    "${self}/modules/daily-drive"
    "${self}/modules/stylix"

    "${self}/modules/users/delta"
  ];

  impermanence.enable = true;

  boot.kernelParams = [
    "nouveau.config=NvClkMode=15"
  ];

  networking.hostName = "pc"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";
}

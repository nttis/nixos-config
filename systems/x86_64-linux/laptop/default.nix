{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  impermanence.enable = true;

  networking.hostName = "laptop"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";
}

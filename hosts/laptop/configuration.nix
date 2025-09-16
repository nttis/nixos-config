{
  inputs,
  flake,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager

    flake.nixosModules.foundation
    flake.nixosModules.daily-drive
    flake.nixosModules.niri
    flake.nixosModules.impermanence
    flake.nixosModules.bluetooth
    flake.nixosModules.power
    flake.nixosModules.networking
  ];

  users.users.delta = {
    hashedPassword = "$y$j9T$xL4SLWPnBD84BSCranVgE/$RltD31LVzUEpqWONk01QUQKzcEZj0F7D2Ephjns4BLB";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  networking.hostName = "laptop"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";
}

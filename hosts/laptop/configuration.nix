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

    flake.nixosModules.delta
  ];

  networking.hostName = "laptop"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";
}

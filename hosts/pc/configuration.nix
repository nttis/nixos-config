{
  inputs,
  flake,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix

    inputs.impermanence.nixosModules.impermanence
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix

    flake.nixosModules.foundation
    flake.nixosModules.daily-drive
    flake.nixosModules.impermanence
    flake.nixosModules.networking
    flake.nixosModules.stylix
  ];

  users.users.delta = {
    hashedPassword = "$y$j9T$xL4SLWPnBD84BSCranVgE/$RltD31LVzUEpqWONk01QUQKzcEZj0F7D2Ephjns4BLB";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  networking.hostName = "pc"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";

  nixpkgs.config.nvidia.acceptLicense = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxKernel.packages.linux_6_12;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;

  services.xserver = {
    enable = lib.mkForce true;
    enableTearFree = true;
    videoDrivers = [ "nvidia" ];

    desktopManager.cinnamon = {
      enable = true;
    };
  };
}

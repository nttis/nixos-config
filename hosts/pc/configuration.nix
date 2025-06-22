{
  config,
  inputs,
  pkgs,
  flake,
  lib,
  ...
}: {
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
    extraGroups = ["wheel"];
  };

  networking.hostName = "pc"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";

  # fuck

  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_6;

  services.xserver = {
    enable = lib.mkForce true;

    videoDrivers = ["nvidia"];

    desktopManager = {
      xfce.enable = true;
      xterm.enable = false;
    };

    displayManager.lightdm = {
      enable = true;
      greeters.gtk.enable = true;
    };
  };

  programs.niri.enable = lib.mkForce false;

  services.greetd.enable = lib.mkForce false;
}

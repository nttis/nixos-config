{
  inputs,
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

  impermanence.enable = true;

  users.users.delta = {
    hashedPassword = "$y$j9T$xL4SLWPnBD84BSCranVgE/$RltD31LVzUEpqWONk01QUQKzcEZj0F7D2Ephjns4BLB";
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  services.xserver = {
    enable = lib.mkForce true;
    desktopManager = {
      xfce.enable = true;
      xterm.enable = false;
    };
  };

  boot.kernelParams = [
    "nouveau.config=NvClkMode=15"
  ];

  networking.hostName = "pc"; # Define your hostname
  time.timeZone = "Asia/Ho_Chi_Minh";
}

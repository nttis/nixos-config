{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  allowedBootloaders = ["systemd-boot" "grub"];
  chosenBootloader = config.${namespace}.boot.bootloader.bootloader;
in
  lib.${namespace}.mkModule ./. config
  {
    enable = lib.mkEnableOption "the bootloader";
    bootloader = lib.mkOption {
      default = "grub";
      example = "systemd-boot";
      description = "The bootloader to use. Supports either `systemd-boot` or `grub`";
      type = lib.types.enum allowedBootloaders;
    };
  }
  {
    boot.loader.grub = lib.mkIf (chosenBootloader == "grub") {
      enable = true;
      efiSupport = true;
      useOSProber = true;

      device = "/dev/disk/by-label/ESP";
      forceInstall = true; # Force GRUB to install itself on the EFI System Partition

      theme = "${pkgs.libsForQt5.breeze-grub}/grub/themes/breeze";
    };

    boot.loader.systemd-boot = lib.mkIf (chosenBootloader == "systemd-boot") {
      enable = true;
    };

    boot.loader.efi.canTouchEfiVariables = true;
  }

{ self, ... }:
{
  flake.modules.nixos."hosts.laptop" = {
    imports = with self.modules.nixos; [
      impermanence
      systemd-boot
      memtest86
      tlp
      thermald
      networking
      nix-ld
      foundation
      daily-drive
      modern
      niri
      mic-fix
      virtual-mic

      self.modules.nixos."users.delta"
    ];

    networking.hostName = "laptop";
    time.timeZone = "Asia/Ho_Chi_Minh";

    environment.etc."machine-id".text = "fd605a1afeff4fffa51c501879853050";

    boot.initrd.availableKernelModules = [
      "vmd"
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "sd_mod"
    ];

    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.extraModulePackages = [ ];

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;

    system.stateVersion = "24.05";
  };
}

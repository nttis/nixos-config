{ self, ... }:
{
  flake.modules.nixos."hosts.pc".imports = with self.modules.nixos; [
    impermanence
    systemd-boot
    memtest86
    networking
    nix-ld
    foundation
    daily-drive
    nvidia-legacy
    plasma

    self.modules.nixos."users.delta"
  ];

  flake.modules.nixos."hosts.pc" = {
    networking.hostName = "pc";
    time.timeZone = "Asia/Ho_Chi_Minh";

    environment.etc."machine-id".text = "717af9368b07a6ba593fd87f68e4f6f2";

    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];

    boot.initrd.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;
    hardware.enableRedistributableFirmware = true;

    system.stateVersion = "24.05";
  };
}

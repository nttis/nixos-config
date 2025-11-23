{ self, ... }:
{
  flake.modules.nixos."hosts.pc" =
    { pkgs, lib, ... }:
    {
      imports = with self.modules.nixos; [
        impermanence
        systemd-boot
        memtest86
        networking
        nix-ld
        foundation
        daily-drive
        nvidia-legacy

        self.modules.nixos."users.delta"
      ];

      networking.hostName = "pc";
      time.timeZone = "Asia/Ho_Chi_Minh";

      services.xserver = {
        enable = lib.mkForce true;
        desktopManager.xfce = {
          enable = true;
          enableScreensaver = false;
        };
      };

      xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-xapp
      ];

      environment.etc."machine-id".text = "717af9368b07a6ba593fd87f68e4f6f2";

      boot = {
        kernelModules = [ "i2c-dev" ];

        initrd.availableKernelModules = [
          "xhci_pci"
          "ahci"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];
      };

      nixpkgs.hostPlatform = "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = true;
      hardware.enableRedistributableFirmware = true;

      system.stateVersion = "24.05";
    };
}

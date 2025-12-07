{ ... }:
{
  flake.modules.nixos.modern =
    { pkgs, ... }:
    {
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        initrd.systemd.enable = true;
      };

      system = {
        nixos-init.enable = true;
        etc.overlay.enable = true;
      };

      services = {
        userborn.enable = true;
        dbus.implementation = "broker";
      };
    };
}

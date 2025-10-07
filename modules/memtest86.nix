{ ... }:
{
  flake.modules.nixos.memtest86 = {
    boot.loader.systemd-boot = {
      memtest86.enable = true;
    };
  };
}

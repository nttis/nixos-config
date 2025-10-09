{ ... }:
{
  flake.modules.nixos.scanners = {
    hardware.sane = {
      enable = true;
      dsseries.enable = true;
      brscan5.enable = true;
      brscan4.enable = true;
    };
  };
}

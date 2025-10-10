{ ... }:
{
  flake.modules.nixos.scanners =
    { pkgs, ... }:
    {
      hardware.sane = {
        enable = true;
        dsseries.enable = true;
        brscan5.enable = true;
        brscan4.enable = true;
      };

      environment.systemPackages = [
        pkgs.simple-scan
      ];
    };
}

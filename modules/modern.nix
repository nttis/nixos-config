{ ... }:
{
  flake.modules.nixos.modern =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    };
}

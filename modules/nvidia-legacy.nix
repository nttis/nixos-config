{ ... }:
{
  flake.modules.nixos.nvidia-legacy =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      nixpkgs.config.nvidia.acceptLicense = true;
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      services.xserver.videoDrivers = [ "nvidia" ];
    };
}

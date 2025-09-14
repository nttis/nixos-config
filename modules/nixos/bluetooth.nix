{ pkgs, ... }:
{
  imports = [ ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  environment.systemPackages = [
    pkgs.bluetuith
  ];
}

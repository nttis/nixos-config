{ ... }:
{
  flake.modules.nixos.bluetooth =
    { pkgs, ... }:
    {
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
      };

      environment.systemPackages = with pkgs; [
        bluetuith
      ];
    };
}

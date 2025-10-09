{ ... }:
{
  flake.modules.nixos.plasma =
    { lib, ... }:
    {
      services.xserver.enable = lib.mkForce true;

      services.displayManager = {
        sddm.enable = true;
        defaultSession = "plasmax11";
      };

      services.desktopManager.plasma6 = {
        enable = true;
      };
    };
}

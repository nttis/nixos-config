{ ... }:
{
  flake.modules.nixos.plasma = {
    services.desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = false;
    };

    services.displayManager.sddm = {
      enable = true;
      wayland = {
        enable = true;
        compositor = "kwin";
      };
    };
  };

  flake.modules.nixos.tlp =
    { lib, ... }:
    {
      # Force disable power-profiles-daemon if tlp is in use
      services.power-profiles-daemon.enable = lib.mkForce false;
    };
}

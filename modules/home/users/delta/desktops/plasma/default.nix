
{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific KDE Plasma configurations";
} {
  programs.plasma = {
    enable = true;

    input.touchpads = [
      # TODO: figure out a way to NOT hardcode these...
      {
        name = "ELAN0703:00 04F3:31BF Touchpad";
        vendorId = "04F3";
        productId = "31BF";
        
        enable = true;
        naturalScroll = true;
        pointerSpeed = 0.15;
        scrollSpeed = 3;
      }
    ];

    powerdevil = {
      AC = {
        autoSuspend.action = "nothing";
        whenLaptopLidClosed = "turnOffScreen";
        dimDisplay.enable = false;
        turnOffDisplay.idleTimeout = "never";
        displayBrightness = 100;
      };
      battery = {
        autoSuspend.action = "nothing";
        whenLaptopLidClosed = "turnOffScreen";
        dimDisplay.enable = false;
        turnOffDisplay.idleTimeout = "never";
        displayBrightness = 30;
      };
      lowBattery = {
        autoSuspend.action = "nothing";
        whenLaptopLidClosed = "turnOffScreen";
        dimDisplay.enable = false;
        turnOffDisplay.idleTimeout = "never";
        displayBrightness = 30;
      };
    };
  };
}

{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "printing";
} {
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      # hplip
      # hplipWithPlugin
      postscript-lexmark
      splix
      brlaser
      brgenml1cupswrapper
      brgenml1lpr
    ];
  };

  hardware.printers.ensurePrinters = [
    # Home printer
    {
      name = "Brother_HL-L2320D_series";
      location = "Local Printer";
      deviceUri = "usb://Brother/HL-L2320D%20series?serial=E73793B0N161175";
      model = "drv:///brlaser.drv/brl2320d.ppd";
    }
  ];
}

{ ... }:
{
  flake.modules.nixos.printing =
    { pkgs, ... }:
    {
      services.printing = {
        enable = true;
        startWhenNeeded = true;
        cups-pdf.enable = true;

        drivers = with pkgs; [
          brlaser
          gutenprint
          gutenprint-bin
          splix
          epson-escpr
          epson-escpr2
        ];
      };
    };
}

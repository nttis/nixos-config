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
          # TODO: remove when nixpkgs resolves the CMageddon4
          (brlaser.overrideAttrs (prev: {
            cmakeFlags = prev.cmakeFlags ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
          }))

          gutenprint
          gutenprint-bin
          splix
          epson-escpr
          epson-escpr2
        ];
      };
    };
}

{ inputs, self, ... }:
{
  flake.modules.nixos.foundation =
    { pkgs, ... }:
    {
      imports = [
        self.modules.nixos.nix
        self.modules.nixos.nttpkgs
      ];

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          inputs.firefox-addons.overlays.default

          (final: prev: {
            # Temporary overlay to fix build failure due to a hash mismatch in the patch
            # https://hydra.nixos.org/build/318300554
            # Doesn't seem like a nixpkgs issue exists as of yet (04-01-2026)
            linux-wifi-hotspot = prev.linux-wifi-hotspot.overrideAttrs {
              patches = [
                (pkgs.fetchpatch {
                  url = "https://github.com/lakinduakash/linux-wifi-hotspot/commit/a3fce4b3ee9371eeb7b300fa7e9f291d93986db3.patch";
                  hash = "sha256-4XTboYXbzqhctWvd71ntXEQ4M6hI3Ex+2j+GVrhpiWc=";
                })
              ];
            };
          })
        ];
      };

      # Disable bloat:tm:
      programs.nano.enable = false;
      services.xserver.enable = false;

      programs = {
        nh.enable = true;
        fish.enable = true;
      };

      users = {
        mutableUsers = false;
        defaultUserShell = pkgs.fish;
      };
    };
}

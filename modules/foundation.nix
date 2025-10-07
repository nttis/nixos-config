{ inputs, self, ... }:
{
  flake.modules.nixos.foundation =
    { pkgs, ... }:
    {
      imports = [ self.modules.nixos.nix ];

      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          inputs.firefox-addons.overlays.default

          (
            prev: final:
            final.lib.packagesFromDirectoryRecursive {
              inherit (final) callPackage newScope;
              directory = "${inputs.nttpkgs}/packages";
            }
          )
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

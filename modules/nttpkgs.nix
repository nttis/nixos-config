{ inputs, ... }:
{
  flake.modules.nixos.nttpkgs = {
    nixpkgs = {
      config.allowUnfree = true;
      overlays = [
        (
          prev: final:
          final.lib.packagesFromDirectoryRecursive {
            inherit (final) callPackage newScope;
            directory = "${inputs.nttpkgs}/packages";
          }
        )
      ];
    };
  };
}

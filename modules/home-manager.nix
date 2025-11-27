{ inputs, ... }:
{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      sharedModules = [ { home.enableNixpkgsReleaseCheck = false; } ];
    };
  };
}

{ inputs }:
{
  # Function to make a system
  mkSystem =
    system: entrypoint:
    let
      pkgs = import inputs.nixpkgs {
        system = system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs pkgs;
      };
      system = system;
      modules = [
        entrypoint

        inputs.stylix.nixosModules.stylix
        inputs.nix-flatpak.nixosModules.nix-flatpak
        inputs.home-manager.nixosModules.default
        inputs.impermanence.nixosModules.impermanence
      ];
    };
}

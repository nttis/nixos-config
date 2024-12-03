{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # The name "snowfall-lib" is required due to how Snowfall Lib processes your
    # flake's inputs.
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inputs = inputs;
      src = ./.;

      channels-config = {
        # Allow unfree packages.
        allowUnfree = true;
        nvidia = {
          acceptLicense = true;
        };
      };

      systems.modules.nixos = with inputs; [
        impermanence.nixosModules.impermanence
        stylix.nixosModules.stylix
      ];

      homes.modules = with inputs; [
        impermanence.homeManagerModules.impermanence
      ];

      snowfall = {
        root = ./.;
        namespace = "anima";

        metadata = {
          name = "system-flake";
          title = "NixOS system flake configuration";
        };
      };
    };
}

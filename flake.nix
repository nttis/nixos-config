{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    config = inputs.flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          system = system;
        };
      in {
        packages = {
          tree-sitter-ziggy = pkgs.callPackage ./packages/tree-sitter-ziggy {};
          tree-sitter-asciidoc = pkgs.callPackage ./packages/tree-sitter-asciidoc {};
          tree-sitter-luau = pkgs.callPackage ./packages/tree-sitter-luau {};
        };
      }
    );

    mkSystem = systemArch: configFilePath:
      nixpkgs.lib.nixosSystem rec {
        specialArgs = {
          inputs = inputs;
          self = self;
          system = systemArch;
        };

        modules = [
          inputs.impermanence.nixosModules.impermanence
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix

          # Pardon the intrusion
          {
            nixpkgs = {
              overlays = [inputs.firefox-addons.overlays.default];
              config.allowUnfree = true;
            };

            home-manager = {
              extraSpecialArgs = specialArgs;
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }

          configFilePath
        ];
      };

    nixosConfigurations = {
      pc = mkSystem "x86_64-linux" ./systems/pc;
      laptop = mkSystem "x86_64-linux" ./systems/laptop;
    };
  in
    config
    // {
      nixosConfigurations = nixosConfigurations;
    };
}

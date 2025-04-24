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
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    # Overridden to a PR that implements Flatpak shimming
    nixpak = {
      url = "github:nixpak/nixpak?ref=960898f79e83aa68c75876794450019ddfdb9157";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixcord is really frequently broken...
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

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

          configFilePath

          # Pardon the intrusion
          {
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.useGlobalPkgs = true;
          }
        ];
      };
  in {
    nixosConfigurations = {
      pc = mkSystem "x86_64-linux" ./systems/pc;
      laptop = mkSystem "x86_64-linux" ./systems/laptop;
    };

    # homeManagerConfigurations = {
    #   delta = let
    #     pkgs = import nixpkgs {
    #       system = "x86_64-linux"; # hmm...
    #     };
    #   in
    #     inputs.home-manager.lib.homeManagerConfiguration {
    #       pkgs = pkgs;
    #       modules = [
    #         ./homes/delta
    #       ];
    #     };
    # };

    packages = forAllSystems (system: let
      pkgs = import nixpkgs {
        system = system;
      };
    in {
      tree-sitter-ziggy = pkgs.callPackage ./packages/tree-sitter-ziggy {};
      tree-sitter-asciidoc = pkgs.callPackage ./packages/tree-sitter-asciidoc {};
    });
  };
}

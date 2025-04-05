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

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixcord is really frequently broken...
    nixcord = {
      url = "github:kaylorben/nixcord";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
      };

      systems.modules.nixos = with inputs; [
        impermanence.nixosModules.impermanence
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
      ];

      homes.modules = with inputs; [
        nix-flatpak.homeManagerModules.nix-flatpak
        nixcord.homeManagerModules.nixcord
      ];

      snowfall = {
        root = ./.;
        namespace = "anima";

        meta = {
          name = "anima";
          title = "NixOS configuration";
        };
      };
    };
}

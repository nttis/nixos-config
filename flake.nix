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

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls = {
      url = "github:zigtools/zls";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ashell = {
      url = "github:MalpenZibo/ashell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    /*
    INPUTS THAT MUST BE UPDATED MANUALLY
    INPUTS THAT MUST BE UPDATED MANUALLY
    INPUTS THAT MUST BE UPDATED MANUALLY
    Do remember to check for releases for these
    */
    jitendex = {
      url = "https://github.com/stephenmk/stephenmk.github.io/releases/download/2025.03.04.0/jitendex-mdict.zip";
      flake = false;
    };

    # Nixcord is really frequently broken...
    nixcord = {
      url = "github:kaylorben/nixcord?rev=677db34f35bdffcdca07246099ea3b22fc6688dc";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inputs = inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
        nvidia = {
          acceptLicense = true;
        };
      };

      systems.modules.nixos = with inputs; [
        impermanence.nixosModules.impermanence
        stylix.nixosModules.stylix
        sops-nix.nixosModules.sops
      ];

      homes.modules = with inputs; [
        impermanence.homeManagerModules.impermanence
        nixcord.homeManagerModules.nixcord
        plasma-manager.homeManagerModules.plasma-manager
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

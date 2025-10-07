{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nttpkgs = {
      url = "github:nttis/nttpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } (
      { lib, ... }:
      {
        imports =
          let
            filterNix = path: lib.fileset.fileFilter (file: file.hasExt "nix") path;
          in
          lib.fileset.toList (
            lib.fileset.unions [
              (filterNix ./modules)
              (filterNix ./hosts)
            ]
          );

        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];
      }
    );
}

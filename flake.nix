{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    {
      nixosConfigurations.laptop =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs system;
          };
          system = pkgs.system;
          modules = [
            ./hosts/laptop

            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.home-manager.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
          ];
        };

      nixosConfigurations.pc =
        let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs system;
          };
          system = pkgs.system;
          modules = [
            ./hosts/pc

            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.home-manager.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
          ];
        };
    };
}

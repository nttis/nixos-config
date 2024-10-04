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

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    ags.url = "github:Aylur/ags/v2";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        system = system;
        config.allowUnfree = true;
      };

      mkSystem =
        system: entrypoint:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs;
          };
          system = system;
          modules = [
            entrypoint

            inputs.home-manager.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
            inputs.nix-flatpak.nixosModules.nix-flatpak
            inputs.stylix.nixosModules.stylix
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem system ./hosts/laptop;
        pc = mkSystem system ./hosts/pc;
      };
    };
}

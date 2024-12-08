{
  lib,
  config,
  inputs,
  pkgs,
  namespace,
  ...
}: {
  options.${namespace}.suites.common = {
    enable = lib.mkEnableOption "common configurations";
  };

  config = lib.mkIf config.${namespace}.suites.common.enable {
    anima = {
      boot.systemd.enable = true;
      filesystem.enable = true;

      apps = {
        nh.enable = true;
      };

      desktops = {
        xfce.enable = true;
      };

      services = {
        scanning.enable = true;
        printing.enable = true;
        networking.enable = true;
      };

      misc = {
        substituters.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      alejandra
      nixd
    ];

    nix = {
      package = pkgs.lix;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    };

    users.mutableUsers = false;
    users.defaultUserShell = pkgs.fish;

    programs.fish.enable = true;

    services.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}

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

      desktops.xfce.enable = true;
    };

    networking.networkmanager = {
      enable = true;
    };

    programs.nm-applet.enable = true;
    programs.fish.enable = true;

    nix = {
      package = pkgs.nixVersions.latest;
      nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    };

    environment.systemPackages = with pkgs; [
      alejandra
      nixd
    ];

    users.mutableUsers = false;
    users.defaultUserShell = pkgs.fish;

    services.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };
  };
}

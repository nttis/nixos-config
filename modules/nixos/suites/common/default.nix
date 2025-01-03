{
  lib,
  config,
  inputs,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "common configurations";
} {
  anima = {
    boot = {
      systemd.enable = true;
      filesystem.enable = true;
      kernel.latest.enable = true;
    };

    apps = {
      nh.enable = true;
    };

    desktops = {
      hyprland.enable = true;
      greetd.enable = true;
    };

    services = {
      scanning.enable = true;
      printing.enable = true;
      networking.enable = true;

      sops-nix.enable = true;
      ssh-client.enable = true;
    };

    misc = {
      substituters.enable = true;
    };
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.nushell;

  programs.nix-ld.enable = true;

  environment.memoryAllocator.provider = "libc";
}

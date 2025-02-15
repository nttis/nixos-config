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
    core = {
      bootloader = {
        enable = true;
        bootloader = "systemd-boot";
      };

      kernel = {
        enable = true;
        distribution = "zen";
      };

      filesystem = {
        enable = true;
        type = "impermanence";
      };

      plymouth.enable = true;
    };

    apps = {
      nh.enable = true;
      libarchive.enable = true;
    };

    desktops = {
      greeter = {
        enable = true;
        type = "greetd";
      };

      desktop = {
        enable = true;
        type = "hyprland";
      };
    };

    services = {
      scanning.enable = true;
      printing.enable = true;
      networking.enable = true;
      sound.enable = true;

      sops-nix.enable = true;
      ssh-client.enable = true;
    };

    misc = {
      substituters.enable = false; # Disabled for now because they are unused
    };
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    package = pkgs.lix;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [8000 8080];
  };

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.nushell;

  programs.nix-ld.enable = true;
  hardware.enableAllFirmware = true;
}

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
      xfce.enable = true;
      awesome.enable = true;
      i3.enable = true;

      xserver.enable = true;
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

  environment.systemPackages = with pkgs; [
    alejandra
    nixd
  ];

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  };

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.fish;

  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
}

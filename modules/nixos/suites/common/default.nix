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
    };

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

  # TODO: maybe consider moving this to modules?
  programs.ssh = {
    startAgent = true;
    enableAskPassword = true;
    agentTimeout = null; # Maybe set a time limit??
  };

  services.openssh = {
    enable = true;
  };
}

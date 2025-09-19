{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.firefox-addons.overlays.default

      (
        prev: final:
        final.lib.packagesFromDirectoryRecursive {
          inherit (final) callPackage newScope;
          directory = "${inputs.nttpkgs}/packages";
        }
      )
    ];
  };

  # Disable bloat:tm:
  programs.nano.enable = false;
  services.xserver.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot = {
    enable = true;
    memtest86.enable = true;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      show-trace = true;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      flake-registry = "";

      substituters = [
        "https://nttis.cachix.org"
      ];

      trusted-public-keys = [
        "nttis.cachix.org-1:ohXet8jSa6Am+ncf56FgHHfVd0qlqvbPckrGXmE48cs="
      ];
    };
  };

  programs = {
    nh.enable = true;
    fish.enable = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        alsa-lib
        pulseaudio
        pipewire
        wayland
        sdl3
        SDL2
      ];
    };
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.fish;
  };

  system.stateVersion = "24.05";
}

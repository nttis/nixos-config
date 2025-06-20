{
  inputs,
  flake,
  pkgs,
  ...
}: {
  imports = [];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    inputs.firefox-addons.overlays.default
  ];

  # Disable bloat:tm:
  programs.nano.enable = false;
  services.xserver.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot = {
    enable = true;
  };

  nix.settings = {
    show-trace = true;
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://nttis.cachix.org"
    ];

    trusted-public-keys = [
      "nttis.cachix.org-1:ohXet8jSa6Am+ncf56FgHHfVd0qlqvbPckrGXmE48cs="
    ];
  };

  programs = {
    nh.enable = true;
    nix-ld.enable = true;
    fish.enable = true;
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.fish;
  };

  system.stateVersion = "24.05";
}

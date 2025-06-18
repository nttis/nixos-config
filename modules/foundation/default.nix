{
  inputs,
  self,
  pkgs,
  system,
  ...
}: {
  imports = [];

  nixpkgs.overlays = [
    # This overlay applies all of our self-defined packages to nixpkgs globally
    # so we can simply refer to them with `pkgs.package-name` everywhere.
    (final: prev: self.packages.${system})

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

  programs.nh = {
    enable = true;
    flake = self.outPath;
  };

  programs.nix-ld = {
    enable = true;
  };

  programs.fish.enable = true;

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.fish;
  };

  system.stateVersion = "24.05";
}

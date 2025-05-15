{
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
  ];

  hardware = {
    graphics.enable = true;
  };

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
  };

  programs.fish.enable = true;
  programs.nh = {
    enable = true;
    flake = "/persist/nixos";
  };

  programs.nix-ld = {
    enable = true;
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.fish;
  };

  system.stateVersion = "24.05";
}

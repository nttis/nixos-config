{
  pkgs,
  config,
  ...
}: {
  imports = [];

  home-manager.extraSpecialArgs = {
    # Options propagated down to home-manager
    systemOptions = {
      impermanence.enable = config.impermanence.enable;
    };
  };

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

  services.dbus = {
    implementation = "broker";
  };

  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.fish;
  };

  system.stateVersion = "24.05";
}

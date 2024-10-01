# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./boot.nix
  ];

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.hostName = "laptop"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # Desktop environment
  services.xserver = {
    enable = true;
    exportConfiguration = true;

    desktopManager.xterm.enable = false;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    konsole
    plasma-browser-integration
    ark
    krdp
    kwalletmanager
    kwallet-pam
    kwallet
    okular
    kate
    kwrited
  ];

  environment.gnome.excludePackages = with pkgs; [
    xterm
    gnome-tour
  ];

  documentation.nixos.enable = false;

  programs.hyprland = {
    # enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = inputs.hyprland.packages."${pkgs.system}".xdg-desktop-portal-hyprland;
  };

  environment.systemPackages = with pkgs; [
    rofi-wayland
    dunst
    waybar
  ];

  hardware.enableAllFirmware = true;
  hardware.bluetooth.powerOnBoot = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  programs.light.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Users
  users.mutableUsers = false;

  users.users.root = {
    initialHashedPassword = "$y$j9T$eu6j5bHOyaRCdDD7DBBR4/$N1W/opayWmm3OHnnbpQd64Txp2v5sPrGJsepnlHaxO8";
  };

  users.users.delta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$y$j9T$vi.Fiw9MHEijNtyrqt1vF.$d8Ce0EJkAwNGZWYbdaC4ezukqk2D4xkOJ5IB18ykdk4";
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "delta" = import ./../../users/delta.nix;
    };

    useGlobalPkgs = true;
    useUserPackages = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [
      {
        name = "sober";
        location = "https://sober.vinegarhq.org/repo";
        args = "--no-gpg-verify"; # bruh fuck sober
      }
    ];
    packages = [
      {
        appId = "org.vinegarhq.Sober";
        origin = "sober";
      }
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

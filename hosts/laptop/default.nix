# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  inputs,
  ...
}:
let
  rootPath = ./../..;
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    (rootPath + /modules/nixos)
  ];

  impermanence.enable = true;
  gnome.enable = true;
  flatpak.enable = true;

  networking.hostName = "laptop"; # Define your hostname.

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # Users
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
      "delta" = import (rootPath + /users/delta);
    };

    useGlobalPkgs = true;
    useUserPackages = true;
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

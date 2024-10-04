{ lib, ... }:
{
  imports = [
    ./boot.nix
    ./common.nix

    ./impermanence.nix

    ./desktops/plasma.nix
    ./desktops/gnome.nix
    ./desktops/hyprland.nix

    ./services/pipewire.nix
    ./services/flatpak.nix

    ./stylix.nix
  ];

  pipewire.enable = lib.mkDefault true;
  stylixModule.enable = lib.mkDefault true;
}

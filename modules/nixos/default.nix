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
    ./services/speechd.nix

    ./stylix.nix
  ];

  pipewire.enable = lib.mkDefault true;
  stylixModule.enable = lib.mkDefault true;
  speechd.enable = lib.mkDefault true;
}

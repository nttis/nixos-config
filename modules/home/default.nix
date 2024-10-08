{ lib, ... }:
{
  imports = [
    ./shells
    ./apps

    ./impermanence.nix
    ./hyprland.nix
  ];

  git.enable = lib.mkDefault true;

  # Shells (and kitty ig)
  kitty.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;

  firefox.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;
  vesktop.enable = lib.mkDefault true;
}

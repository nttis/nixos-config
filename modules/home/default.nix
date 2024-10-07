{ lib, ... }:
{
  imports = [
    ./apps/firefox.nix
    ./apps/git.nix
    ./apps/kitty.nix
    ./apps/fish.nix
    ./apps/vscode.nix
    ./apps/vesktop.nix

    ./impermanence.nix
    ./hyprland.nix
  ];

  firefox.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
  fish.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;
  vesktop.enable = lib.mkDefault true;
}

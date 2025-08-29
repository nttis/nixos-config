{ flake, lib, ... }:
{
  imports = [
    flake.homeModules.delta
  ];

  programs.waybar.enable = lib.mkForce false;
}

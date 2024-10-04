{ pkgs, ... }:
{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];

    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";

  hardware.graphics.enable = true;
  hardware.enableAllFirmware = true;
  hardware.bluetooth.powerOnBoot = false;

  documentation.nixos.enable = false;

  # Services
  services = {
    printing.enable = true;

    orca.enable = false;
    speechd.enable = false;

    openssh.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts

      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      noto-fonts-color-emoji
      noto-fonts-emoji
    ];
  };

  # Rare system-wide programs
  programs.nh = {
    enable = true;
  };

  environment.variables = {
    FLAKE = "/persist/nixos";
  };

  users.mutableUsers = false;
}

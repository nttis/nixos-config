{ lib, config, ... }:
{
  options = {
    kitty.enable = lib.mkEnableOption "enables kitty terminal emulator";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        shell = "fish";
      };
    };
  };
}

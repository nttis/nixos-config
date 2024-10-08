{ lib, config, ... }:
{
  options = {
    kitty = {
      enable = lib.mkEnableOption "enables kitty terminal emulator";
      shell = lib.mkOption {
        description = "the shell used by default";
        example = "zsh";
        default = "fish";
        type = lib.types.str;
      };
    };
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        shell = config.kitty.shell;
      };
    };
  };
}

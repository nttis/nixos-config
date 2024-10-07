{ lib, config, ... }:
{
  options = {
    fish.enable = lib.mkEnableOption "enables fish shell";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      shellInit = "cbonsai -p";
    };
  };
}

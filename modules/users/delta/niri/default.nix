{ ... }:
{
  flake.modules.homeManager."niri@delta" = {
    xdg.configFile."niri/config.kdl" = {
      enable = true;
      force = true;
      source = ./config.kdl;
    };
  };
}

{ inputs, ... }:
{
  flake.modules.homeManager."plasma@delta" = {
    imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

    programs.plasma = {
      enable = true;

      input = {
        keyboard = {
          repeatDelay = 300;
          repeatRate = 35;
        };
      };

      panels = [
        {
          lengthMode = "fill";
          hiding = "none";
          floating = false;
          screen = "all";
        }
      ];
    };
  };
}

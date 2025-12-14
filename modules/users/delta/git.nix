{ ... }:
{
  flake.modules.homeManager."git@delta" = {
    programs.git = {
      enable = true;
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        ui = {
          paginate = "never";
        };
      };
    };
  };
}

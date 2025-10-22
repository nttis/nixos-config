{ ... }:
{
  flake.modules.homeManager."git@delta" = {
    programs.git = {
      enable = true;

      settings = {
        user.name = "nttis";
        user.email = "slush-gulf-rural@duck.com";
      };
    };

    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
          name = "nttis";
          email = "slush-gulf-rural@duck.com";
        };

        ui = {
          paginate = "never";
        };
      };
    };
  };
}

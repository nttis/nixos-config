{ ... }:
{
  imports = [ ];

  programs.git = {
    enable = true;

    userName = "nttis";
    userEmail = "slush-gulf-rural@duck.com";
  };

  programs.gitui = {
    enable = true;
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
}

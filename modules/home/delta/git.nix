{...}: {
  imports = [];

  programs.git = {
    enable = true;

    userName = "nttis";
    userEmail = "slush-gulf-rural@duck.com";
  };

  programs.gitui = {
    enable = true;
  };
}

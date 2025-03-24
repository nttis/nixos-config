{pkgs, ...}: {
  imports = [];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    userName = "nttis";
    userEmail = "slush-gulf-rural@duck.com";
  };

  programs.gitui = {
    enable = true;
  };
}

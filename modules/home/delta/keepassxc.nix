{ config, ... }:
{
  imports = [ ];

  programs.keepassxc = {
    enable = true;
    settings = {
      Security = {
        IconDownloadFallback = true;
      };

      General = {
        AutoSaveAfterEveryChange = false;
        LastOpenedDatabases = "${config.home.homeDirectory}/Downloads/Passwords.kdbx";
      };

      Browser = {
        Enabled = true;
        AllowGetDatabaseEntriesRequest = true;
        AlwaysAllowAccess = true;
      };

      SSHAgent = {
        Enabled = true;
        UseOpenSSH = true;
        UsePageant = false;
      };
    };
  };
}

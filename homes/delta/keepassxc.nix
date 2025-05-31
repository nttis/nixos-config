{...}: {
  imports = [];

  programs.keepassxc = {
    enable = true;
    settings = {
      Security = {
        IconDownloadFallback = true;
      };

      General = {
        AutoSaveAfterEveryChange = false;
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

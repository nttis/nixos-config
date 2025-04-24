{self, ...}: {
  imports = [];

  users.users.delta = {
    password = "admin";
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  home-manager.users.delta = {
    imports = [
      "${self}/homes/delta"
    ];
  };
}

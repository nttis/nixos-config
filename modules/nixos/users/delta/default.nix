{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user: delta";
} {
  users.users.delta = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialHashedPassword = "$y$j9T$vi.Fiw9MHEijNtyrqt1vF.$d8Ce0EJkAwNGZWYbdaC4ezukqk2D4xkOJ5IB18ykdk4";
  };

  systemd = lib.mkIf config.${namespace}.impermanence.enable {
    tmpfiles.settings = {
      "delta-persist" = {
        "/persist/delta" = {
          d = {
            user = "delta";
            mode = "700";
          };
        };
      };

      "delta-nixos-permission" = {
        "/persist/nixos" = {
          Z = {
            user = "delta";
            mode = "700";
          };
        };
      };
    };
  };
}

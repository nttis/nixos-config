{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "OpenSSH server";
} {
  services.openssh = {
    enable = true;
    hostKeys = [];
    settings = {
      PermitRootLogin = "no";
      UseDns = true;
      PasswordAuthentication = false;
    };
  };
}

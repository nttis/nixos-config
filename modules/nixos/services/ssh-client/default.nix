{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "SSH client";
} {
  programs.ssh = {
    startAgent = true;
    agentTimeout = null; # Maybe set a time limit??
  };
}

{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.misc.substituters = {
    enable = lib.mkEnableOption "extra substituters";
  };

  config = lib.mkIf config.${namespace}.misc.substituters.enable {
    nix.settings = {
      substituters = ["https://cosmic.cachix.org/"];
      trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
    };
  };
}

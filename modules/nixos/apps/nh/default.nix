{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.apps.nh = {
    enable = lib.mkEnableOption "the nh Nix utility";
  };

  config = lib.mkIf config.${namespace}.apps.nh.enable {
    programs.nh = {
      enable = true;
      flake = "/persist/nixos";
    };
  };
}

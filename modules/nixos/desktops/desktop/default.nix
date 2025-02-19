{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.desktops.desktop;
in {
  imports = [
    ./hyprland.nix
    ./plasma.nix
  ];

  options.${namespace} = {
    desktops.desktop = {
      enable = lib.mkEnableOption "a desktop";

      type = lib.mkOption {
        type = lib.types.enum ["hyprland" "plasma"];
        description = "The desktop to enable";
        default = "hyprland";
        example = "plasma";
      };
    };
  };

  config.${namespace} = lib.mkIf cfg.enable (lib.mkMerge [
    (lib.mkIf (cfg.type == "hyprland") {
      desktops.hyprland.enable = true;
    })

    (lib.mkIf (cfg.type == "plasma") {
      desktops.plasma.enable = true;
    })
  ]);
}

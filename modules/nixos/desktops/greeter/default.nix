{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.desktops.greeter;
in
  lib.${namespace}.mkModule ./. config
  {
    enable = lib.mkEnableOption "a greeter service";
    
    type = lib.mkOption {
      type = lib.types.enum ["greetd" "sddm"];
      description = "The greeter to use";
      default = "greetd";
      example = "sddm";
    };
  } 
  (lib.mkMerge [
    (lib.mkIf
      (cfg.type == "greetd")
      {
        services.greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
              user = "greeter";
            };
          };
        };

        services.xserver.displayManager.startx.enable = true;
      })

    (lib.mkIf (cfg.type == "sddm") {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
    })
  ])

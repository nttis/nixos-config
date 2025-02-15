{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.desktops.desktop;
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "a desktop";
    type = lib.mkOption {
      type = lib.types.enum ["hyprland" "plasma"];
      description = "The desktop to enable";
      default = "hyprland";
      example = "plasma";
    };
  }
  (lib.mkMerge [
    (lib.mkIf
      (cfg.type == "hyprland")
      {
        programs.hyprland = {
          enable = true;
          withUWSM = true;
          xwayland.enable = true;
        };

        security.polkit.enable = true;
        security.soteria.enable = true;

        environment.systemPackages = [
          pkgs.wl-clipboard
        ];
      })

    (lib.mkIf (cfg.type == "plasma") {
      services.desktopManager.plasma6 = {
        enable = true;
      };

      environment.plasma6.excludePackages = with pkgs; [
        kdePackages.konsole
      ];

      services.power-profiles-daemon.enable = lib.mkForce false;
    })
  ])

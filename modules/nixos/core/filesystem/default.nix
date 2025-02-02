{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.core.filesystem;
in (lib.${namespace}.mkModule ./. config
  {
    enable = lib.mkEnableOption "filesystem mounts";

    type = lib.mkOption {
      default = "impermanence";
      example = "standard";
      description = "The type of the filesystem configuration to use";
      type = lib.types.enum ["impermanence" "standard"];
    };
  } {
    fileSystems = lib.mkMerge [
      (lib.mkIf
        (cfg.type == "impermanence")
        {
          "/" = {
            device = "/dev/disk/by-partlabel/nix";
            fsType = "btrfs";
            options = ["subvol=root"];
          };

          "/nix" = {
            device = "/dev/disk/by-partlabel/nix";
            fsType = "btrfs";
            options = [
              "subvol=nix"
              "noatime"
            ];
          };

          "/boot" = {
            device = "/dev/disk/by-partlabel/ESP";
            options = [
              "umask=0077"
              "defaults"
            ];
          };
        })

      (lib.mkIf
        (cfg.type == "standard")
        {
          "/" = {
            device = "/dev/disk/by-partlabel/nix";
            fsType = "ext4";
          };

          "/boot" = {
            device = "/dev/disk/by-partlabel/ESP";
            options = [
              "umask=0077"
              "defaults"
            ];
          };
        })
    ];

    swapDevices = [
      {
        device = "/dev/disk/by-partlabel/swap";
      }
    ];
  })

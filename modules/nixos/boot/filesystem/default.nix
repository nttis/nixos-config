{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.filesystem = {
    enable = lib.mkEnableOption "common filesystem mounts";
  };

  config = lib.mkIf config.${namespace}.filesystem.enable {
    fileSystems."/" = {
      device = "/dev/disk/by-label/nix";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-label/nix";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "noatime"
      ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/ESP";
      options = [
        "umask=0077"
        "defaults"
      ];
    };

    swapDevices = [
      {
        device = "/dev/disk/by-label/swap";
      }
    ];
  };
}

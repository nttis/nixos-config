{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "Impermanence";
} {
  assertions = [
    {
      assertion = config.${namespace}.core.filesystem.type == "impermanence";
      message = "Filesystem is not set to 'impermanence', cannot enable Impermanence support.";
    }
  ];

  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/disk/by-partlabel/nix /btrfs_tmp

    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';

  fileSystems."/persist" = {
    neededForBoot = true;
    device = "/dev/disk/by-partlabel/nix";
    fsType = "btrfs";
    options = [
      "subvol=persist"
      "noatime"
    ];
  };

  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"

      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"

      {
        file = "/var/lib/sops-nix/keys.txt";
        parentDirectory = {
          user = "root";
          group = "root";
          mode = "u=rw,g=r,o=";
        };
      }
    ];
  };

  programs.fuse.userAllowOther = true;
}

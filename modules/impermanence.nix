{
  inputs,
  ...
}:
{
  flake.modules.nixos.impermanence = {
    imports = [ inputs.preservation.nixosModules.preservation ];

    fileSystems = {
      "/" = {
        device = "/dev/disk/by-partlabel/nix";
        fsType = "btrfs";
        options = [ "subvol=root" ];
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

      "/persist" = {
        neededForBoot = true;
        device = "/dev/disk/by-partlabel/nix";
        fsType = "btrfs";
        options = [
          "subvol=persist"
          "noatime"
        ];
      };
    };

    boot.initrd.systemd = {
      enable = true;

      # NOTE: stolen from https://blog.decent.id/post/nixos-systemd-initrd
      services.impermanent-root = {
        description = "Move current root to /old_roots";
        wantedBy = [ "initrd.target" ];

        # This ordering is important: we need this service to run AFTER the initrd filesystem is
        # mounted (ie. /dev exists inside the initrd), but BEFORE the real filesystem is mounted.
        after = [ "initrd-root-device.target" ];
        before = [ "sysroot.mount" ];

        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";

        script = ''
          mkdir -p /btrfs_tmp
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

          for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +14); do
              delete_subvolume_recursively "$i"
          done

          btrfs subvolume create /btrfs_tmp/root
          umount /btrfs_tmp
        '';
      };
    };

    preservation = {
      enable = true;

      preserveAt."/persist/system" = {
        directories = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
        ];

        commonMountOptions = [
          "x-gvfs-hide"
          "x-gdu.hide"
        ];
      };
    };
  };
}

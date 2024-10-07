# NixOS configuration

Personal NixOS configuration, separated into modules for easy modularity.

# Installation

Since this uses Flakes, installation should be fairly straightforward, but it will require you to manually partition your disk.

## Partitioning the disk

This setup requires 3 partitions:

- The EFI System Partition:
  - Can be formatted as any filesystem, NixOS will guess the fs type automatically
  - **Must** be labeled as "ESP"
  - This is where the bootloader (systemd-boot) will be installed
- The main partition:
  - **Must** be formatted as BTRFS
  - **Must** be labeled as "nix"
  - **Must** have 2 (3 if using Impermanence) subvolumes:
    - nix: this subvolume is where the nix store will reside
    - boot: this subvolume is where your entire system will reside. If using Impermanence, this subvolume will be destroyed and recreated on every boot.
    - persist: this subvolume is where data is persisted. Only applicable if using Impermanence.
- The swap partition:
  - **Must** be formatted as linux-swap
  - **Must** be labeled as "swap"
  - Google about swap for more information

## Install

Boot into a live USB with Nix on it. Easiest way is to just use the NixOS live installer.

Mount the partitions you made in the previous step. If you labeled them correctly, simply refer to them with `/dev/disk/by-label/*`.

- Mount the main partition's `root` subvolume at `/mnt`
- Mount the ESP partition at `/mnt/boot`
- Mount the main partition's `nix` subvolume at `/mnt/nix`
- If using Impermanence, mount the main partition's `persist` subvolume at `/mnt/persist`

Clone this repo anywhere. Run `nixos-install --root /mnt --flake /path/to/repo#pc --no-root-passwd` and wait.

Reboot and hopefully it should succeed (lol)

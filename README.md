# NixOS configuration

Personal NixOS configuration, separated into modules for easy modularity.

# Write your own machine configuration (or use mine)

You must run `nixos-generate-config --no-filesystems` to generate `hardware-configuration.nix`. Do NOT use mine, as they most likely will not work with your machines.

This configuration includes 2 configurations in the `hosts` folder: one of my PC and one of my laptop. As these are highly personal and customized to my own needs, you should write your own `host` configuration. **Note in case you want to use them as-is:** they both have Impermanence on.

The `modules` folder contains all the system/home-manager modules. These are things like Impermanence, Pipewire, Hyprland, apps, etc. and can be enabled/disabled at will. Look in the files to learn what exist in there. You should also probably edit these because some of them contain personal wranglings of mine to force them to work according to my own needs.

The `users` folder contains... users! Users are managed with `home-manager`. I intentionally separated users so that I can import any user into any machine I want (if I ever have different users for different machines, that is). Regardless, you should edit the `users` and `hosts` to your liking first.

Alternatively if you are too lazy, just use my `hosts`. They are fairly minimal anyway and probably should work as-is EXCEPT for the `hardware-configuration.nix`. Use your own!

If you decide to write your own host, add them to the `flake.nix` file.

# Installation

Since this uses Flakes, installation should be fairly straightforward, but it will require you to manually partition your disk.

## Partitioning the disk

This configuration uses filesystem labels extensively so that I don't have to fuss with disk UUIDs and all that, so make absolutely sure you label the **filesystems** (**_NOT partitions_**) correctly.

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

Run `nixos-install --root /mnt --flake /path/to/repo#YOUR_HOST_NAME_HERE --no-root-passwd` and wait.

Reboot and hopefully it should succeed (lol)

## Alternatively

If you are already on a NixOS installation **and your disk is partitioned exactly the same way**, simply run `nixos-rebuild boot --flake /path/to/configuration#YOUR_HOST_NAME_HERE`!

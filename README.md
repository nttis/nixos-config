# Personal NixOS configuration

This is my personal configuration for [NixOS](https://nixos.org). Below is a guide/documentation of sorts to explain
how to install this on your own machine.

# Project structure

This configuration uses [Snowfall](https://snowfall.org/guides/lib/quickstart/) to help organize Nix code. Snowfall
is opinionated, so consult its docs to see the meaning of each directory.

# Disk partitioning

There are 2 disk partition schemes available: `standard` and `impermanence`.

> [!CAUTION]
> This configuration uses **partition labels** extensively and exclusively. All partitions must have an appropriate label
> assigned to them, otherwise the config will not recognize them.

> [!CAUTION]
> Partition labels are NOT the same as **filesystem labels**. Do not mix them up!
> If unsure, label both things at once.

`standard` is the most basic/standard Linux disk partitioning scheme:

- An `ext4` partition for root. Labeled as `nix`.
- A `fat32` partition for the ESP. Labeled as `ESP`.

`impermanence` is the layout I personally use on my [Impermanence](https://github.com/nix-community/impermanence)-enabled
machines. It consists of:

- A `fat32` partition for the ESP. Labeled as `ESP`.
- A `btrfs` partition for everything else. Label as `nix`:
  - A `nix` subvolume for the Nix store
  - A `root` subvolume for the root
  - A `persist` subvolume for persisting data

Additionally, both schemes have a `linux-swap` partition for swap space. Labeled as `swap`.

# Bootstrapping

This configuration is tailored to my own needs, so there are certain things you will need to change to make it work
on your machines:

- The `systems` directory. Change the systems to match your machine (including `hardware-configuration.nix` of course)
- The `modules/nixos/suites/common` directory. Change `core.filesystem.type` to match your disk layout.
  - Alternatively, change `modules/nixos/core/filesystem` itself if you use an entirely different layout.
- The `homes` directory. Change the homes to match your `systems` and users.

If you have done all of the above correctly and have a functioning NixOS system:

- Clone this repo somewhere
- Run `nixos-rebuild boot --flake /path/to/repo#hostname`
- Reboot and you should hopefully succeed??

# Configuring

Since this configuration is using Snowflake, all user-defined options are scoped under the `anima` namespace.

All options defined under `modules/nixos` will be available in any system config under `anima`.

All options defined under `modules/home` will be available in any home config under `anima`.

# Miscellaneous notes

- The default bootloader is `systemd-boot`. If you want to use GRUB, know that it will forcefully install GRUB into
the ESP as well (ie. GRUB will live alongside NixOS generations and Windows bootloader if you dualboot). Therefore, I
recommend a minimum of 500MB of space for the ESP.
- Hyprland and KDE Plasma are available. Hyprland is what I use daily, so it receives attention, while Plasma is just... there.
Note that Hyprland has very minimal styling. It is usable though (hopefully).

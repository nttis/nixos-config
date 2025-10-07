{ ... }:
{
  flake.modules.nixos.uinput = {
    hardware.uinput.enable = true;
  };
}

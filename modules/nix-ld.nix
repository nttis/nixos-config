{ ... }:
{
  flake.modules.nixos.nix-ld =
    { pkgs, ... }:
    {
      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          stdenv.cc.cc.lib
          alsa-lib
          pulseaudio
          pipewire
          wayland
          sdl3
          SDL2
        ];
      };
    };
}

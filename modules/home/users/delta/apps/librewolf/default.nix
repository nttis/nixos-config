{
  inputs,
  lib,
  config,
  namespace,
  system,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific librewolf configuration";
} {
  anima = {
    apps = {
      librewolf.enable = true;
    };
  };

  programs.librewolf = {
    profiles.delta = {
      name = "delta";
      isDefault = true;

      extensions = with inputs.firefox-addons.packages.${system}; [
        ublock-origin
      ];
    };
  };
}

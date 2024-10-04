{ lib, config, ... }:
{
  options = {
    flatpak.enable = lib.mkEnableOption "enables Flatpak";
  };

  config = lib.mkIf config.flatpak.enable {
    services.flatpak = {
      enable = true;
      remotes = lib.mkOptionDefault [
        {
          name = "sober";
          location = "https://sober.vinegarhq.org/repo";
          args = "--no-gpg-verify"; # bruh fuck sober
        }
      ];
      packages = [
        {
          appId = "org.vinegarhq.Sober";
          origin = "sober";
        }
      ];
    };
  };
}

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
    # Policies to configure uBlock Origin
    policies = {
      "3rdparty" = {
        Extensions = {
          "uBlock0@raymondhill.net" = {
            toOverwrite = {
              filterLists = [
                "ublock-filters"
                "ublock-badware"
                "ublock-privacy"
                "ublock-abuse"
                "ublock-unbreak"
                "ublock-annoyances"

                "easylist"
                "easyprivacy"
                "fanboy-social"
                "fanboy-thirdparty_social"
                "fanboy-cookiemonster"
                "ublock-cookies-easylist"
                "easylist-chat"
                "easylist-newsletters"
                "easylist-notifications"
                "easylist-annoyances"

                "adguard-social"
                "adguard-generic"
                "adguard-mobile"
                "adguard-cookies"
                "ublock-cookies-adguard"
                "adguard-mobile-app-banners"
                "adguard-other-annoyances"
                "adguard-popup-overlays"
                "adguard-widgets"

                "urlhaus-1"
                "plowe-0"
              ];
            };
          };
        };
      };
    };

    profiles.delta = {
      name = "delta";
      isDefault = true;

      search = {
        default = "DuckDuckGo";
        privateDefault = "DuckDuckGo";
        force = true;

        engines = {
          "Google".metaData.hidden = true;
        };
      };

      settings = {
        "extensions.autoDisableScopes" = 0;
        "browser.translations.enable" = false;
      };

      extensions = with inputs.firefox-addons.packages.${system}; [
        ublock-origin
        sponsorblock
      ];
    };
  };
}

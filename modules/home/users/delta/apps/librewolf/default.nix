{
  inputs,
  lib,
  config,
  namespace,
  system,
  ...
}: let
  user = config.snowfallorg.user.name;
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "user-specific librewolf configuration";
  } {
    programs.librewolf = {
      enable = true;

      profiles.delta = {
        name = "delta";
        isDefault = true;

        search = {
          default = "DuckDuckGo";
          privateDefault = "DuckDuckGo";
          force = true;

          engines = {
            "Google".metaData.hidden = true;
            "Bing".metaData.hidden = true;
            "Wikipedia (en)".metaData.hidden = true;
          };
        };

        settings = {
          "extensions.autoDisableScopes" = 0;
          "browser.translations.enable" = false;
          "browser.search.separatePrivateDefault" = false;
          "browser.toolbars.bookmarks.visibility" = "never";
          "browser.search.suggest.enabled" = true;
          "webgl.disabled" = false;
        };

        extensions = {
          force = true;
        
          packages = with inputs.firefox-addons.packages.${system}; [
            ublock-origin
            sponsorblock
            bitwarden
            duckduckgo-privacy-essentials
            tridactyl
          ];

          settings = {
            "uBlock0@raymondhill.net" = {
              force = true;
              settings = {
                selectedFilterLists = [
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
    };

    home.persistence."/persist/${user}" = lib.mkIf config.${namespace}.users.${user}.impermanence.enable {
      directories = [".librewolf"];
    };
  }

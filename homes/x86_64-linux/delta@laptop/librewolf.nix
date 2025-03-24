{
  inputs,
  lib,
  config,
  system,
  systemOptions,
  ...
}: {
  programs.librewolf = {
    enable = true;

    profiles.delta = {
      name = "delta";
      isDefault = true;

      search = {
        default = "ddg";
        privateDefault = "ddg";
        force = true;

        engines = {
          "google".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
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
          duckduckgo-privacy-essentials # Just to enable the use of Duck emails smh
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

  stylix = lib.mkIf config.stylix.enable {
    targets.librewolf.profileNames = ["delta"];
  };

  home.persistence."/persist/delta" = lib.mkIf systemOptions.impermanence.enable {
    directories = [".librewolf"];
  };
}

{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.default = {
      name = "Default";
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
        "extensions.pocket.enabled" = false;

        "browser.aboutConfig.showWarning" = false;
        "browser.translations.enable" = false;
        "browser.search.separatePrivateDefault" = false;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.search.suggest.enabled" = true;
        "browser.startup.page" = 3;
        "browser.newtabpage.enabled" = false;

        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;

        "doh-rollout.disable-heuristics" = true;
        "network.trr.mode" = 5;
        "signon.rememberSignons" = false;

        "app.shield.optoutstudies.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.updatePing.enabled" = false;

        "identity.fxaccounts.enabled" = false;

        "media.webrtc.camera.allow-pipewire" = true;
      };

      extensions = {
        force = true;

        packages = with pkgs.firefox-addons; [
          ublock-origin
          sponsorblock
          keepassxc-browser
          duckduckgo-privacy-essentials # Just to enable the use of Duck emails smh
          tampermonkey
        ];

        settings = {
          "firefox@tampermonkey.net" = {
            force = true;
            settings = builtins.fromJSON (lib.readFile ./tampermonkey.json);
          };

          "keepassxc-browser@keepassxc.org" = {
            force = true;
            settings = {
              settings = {
                passkeys = true;
              };
            };
          };

          # The DDG extension
          "jid1-ZAdIEUB7XOzOJw@jetpack" = {
            force = true;
            settings = {
              settings = {};
              companyData = {};
              totalPages = 0;
              totalPagesWithTrackers = 0;
              lastStatsResetDate = 0;
            };
          };

          "sponsorBlocker@ajay.app" = {
            force = true;
            settings = {
              alreadyInstalled = true;
            };
          };

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
    targets.firefox.profileNames = ["default"];
  };

  home.persistence."/persist/delta" = {
    directories = [".mozilla/firefox"];
  };
}

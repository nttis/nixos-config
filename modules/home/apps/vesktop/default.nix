# Actually is nixcord
{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.apps.vesktop = {
    enable = lib.mkEnableOption "enables Vesktop";
  };

  config = lib.mkIf config.${namespace}.apps.vesktop.enable {
    # Persist data if Impermanence is enabled
    home = lib.mkIf config.${namespace}.impermanence.enable {
      persistence."/persist/${config.snowfallorg.user.name}" = {
        directories = [
          ".config/vesktop"
        ];
      };
    };

    programs.nixcord = {
      enable = true;

      # Use Vesktop
      discord.enable = false;
      vesktop.enable = true;

      config = {
        enableReactDevtools = true;
        enabledThemes = ["stylix.theme.css"];

        plugins = {
          accountPanelServerProfile = {
            enable = true;
          };
          alwaysExpandRoles = {
            enable = true;
          };
          alwaysTrust = {
            enable = true;
            domain = true;
            file = true;
          };
          anonymiseFileNames = {
            enable = true;
            anonymiseByDefault = true;
          };
          betterGifAltText = {
            enable = true;
          };
          betterGifPicker = {
            enable = true;
          };
          betterNotesBox = {
            enable = true;
            hide = true;
          };
          betterRoleContext = {
            enable = true;
          };
          betterSessions = {
            enable = true;
          };
          betterSettings = {
            enable = true;
          };
          betterUploadButton = {
            enable = true;
          };
          blurNSFW = {
            enable = true;
          };
          callTimer = {
            enable = true;
          };
          clearURLs = {
            enable = true;
          };
          consoleJanitor = {
            enable = true;
          };
          disableCallIdle = {
            enable = true;
          };
          emoteCloner = {
            enable = true;
          };
          experiments = {
            enable = true;
            toolbarDevMenu = true;
          };
          fakeNitro = {
            enable = true;
          };
          favoriteEmojiFirst = {
            enable = true;
          };
          favoriteGifSearch = {
            enable = true;
          };
          fixCodeblockGap = {
            enable = true;
          };
          fixYoutubeEmbeds = {
            enable = true;
          };
          forceOwnerCrown = {
            enable = true;
          };
          keepCurrentChannel = {
            enable = true;
          };
          memberCount = {
            enable = true;
            toolTip = true;
            memberList = false;
          };
          messageLogger = {
            enable = true;
            deleteStyle = "overlay";
            ignoreSelf = true;
          };
          moreUserTags = {
            enable = true;
          };
          mutualGroupDMs = {
            enable = true;
          };
          newGuildSettings = {
            enable = true;
            messages = "only@Mentions";
          };
          noMaskedUrlPaste = {
            enable = true;
          };
          noMosaic = {
            enable = true;
          };
          noOnboardingDelay = {
            enable = true;
          };
          noProfileThemes = {
            enable = true;
          };
          noRPC = {
            enable = true;
          };
          noScreensharePreview = {
            enable = true;
          };
          noTypingAnimation = {
            enable = true;
          };
          noUnblockToJump = {
            enable = true;
          };
          normalizeMessageLinks = {
            enable = true;
          };
          nsfwGateBypass = {
            enable = true;
          };
          pauseInvitesForever = {
            enable = true;
          };
          permissionsViewer = {
            enable = true;
          };
          platformIndicators = {
            enable = true;
          };
          previewMessage = {
            enable = true;
          };
          readAllNotificationsButton = {
            enable = true;
          };
          relationshipNotifier = {
            enable = true;
          };
          roleColorEverywhere = {
            enable = true;
          };
          summaries = {
            enable = true;
          };
          serverInfo = {
            enable = true;
          };
          showHiddenChannels = {
            enable = true;
            showMode = "muted";
          };
          showHiddenThings = {
            enable = true;
          };
          showMeYourName = {
            enable = true;
            mode = "nick-user";
          };
          silentTyping = {
            enable = true;
          };
          spotifyCrack = {
            enable = true;
          };
          stickerPaste = {
            enable = true;
          };
          streamerModeOnStream = {
            enable = true;
          };
          superReactionTweaks = {
            enable = true;
            superReactByDefault = false;
            superReactionPlayingLimit = 0;
          };
          typingTweaks = {
            showAvatars = true;
            alternativeFormatting = true;
          };
          unlockedAvatarZoom = {
            enable = true;
          };
          userVoiceShow = {
            enable = true;
          };
          validReply = {
            enable = true;
          };
          validUser = {
            enable = true;
          };
          voiceChatDoubleClick = {
            enable = true;
          };
          vcNarrator = {
            enable = true;
            sayOwnName = false;
            latinOnly = true;
            voice = "kal16 flite";
          };
          vencordToolbox = {
            enable = true;
          };
          viewIcons = {
            enable = true;
          };
          viewRaw = {
            enable = true;
          };
          voiceDownload = {
            enable = true;
          };
          voiceMessages = {
            enable = true;
          };
          volumeBooster = {
            enable = true;
          };
          youtubeAdblock = {
            enable = true;
          };
          webScreenShareFixes = {
            enable = true;
          };
        };
      };
    };
  };
}
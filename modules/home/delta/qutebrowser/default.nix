{ lib, options, ... }:
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      content = {
        javascript.enabled = false;
      };

      scrolling = {
        bar = "overlay";
      };

      auto_save = {
        session = true;
      };
    };

    keyBindings = {
      normal = {
        "<Ctrl-v>" = "hint links spawn --detach mpv {hint-url}";
        "<Escape>" = "mode-enter normal ;; jseval -q document.activeElement.blur()";

        # "go-libre"
        "gl" = "open https://farside.link/{url}";

        # Swap the j and k bindings
        "J" = "tab-prev";
        "K" = "tab-next";

        # Increase scroll amount
        "j" = "cmd-run-with-count 3 :scroll down";
        "k" = "cmd-run-with-count 3 :scroll up";
        "h" = "cmd-run-with-count 3 :scroll left";
        "l" = "cmd-run-with-count 3 :scroll right";

        "ge" = "scroll-to-perc";
      };
    };

    extraConfig = # python
      ''
        config.set("content.javascript.enabled", True, "*://*.nixos.org/*")
        config.set("content.javascript.enabled", True, "*://*.extranix.com/*")
        config.set("content.javascript.enabled", True, "*://duckduckgo.com/*")
      '';
  };

  home = lib.optionalAttrs (options ? home.persistence) {
    persistence."/persist/delta" = {
      directories = [
        ".local/share/qutebrowser"
      ];
    };
  };
}

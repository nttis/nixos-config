{ lib, options, ... }:
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      content = {
        javascript.enabled = false;
      };
    };

    keyBindings = {
      normal = {
        "<Ctrl-v>" = "spawn mpv {url}";
      };
    };

    extraConfig = # python
      ''
        config.set("content.javascript.enabled", True, "*://*.nixos.org/*")
        config.set("content.javascript.enabled", True, "*://*.github.com/*")
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

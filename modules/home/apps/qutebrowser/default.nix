{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "qutebrowser";
} {
  programs.qutebrowser = {
    enable = true;
    settings = {
      content.blocking = {
        adblock.lists = [
          "https://easylist.to/easylist/easylist.txt"
          "https://easylist.to/easylist/easyprivacy.txt"
          "https://secure.fanboy.co.nz/fanboy-annoyance.txt"
          "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt"
        ];

        hosts.lists = [
          "https://pgl.yoyo.org/as/serverlist.php?hostformat=&showintro=0&mimetype=plaintext"
          "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
        ];

        method = "both";
      };
    };
  };
}

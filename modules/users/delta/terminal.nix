{ ... }:
{
  flake.modules.homeManager."terminal@delta" =
    { pkgs, ... }:
    let
      hotspot = pkgs.writeShellApplication {
        name = "hotspot";

        runtimeInputs = with pkgs; [
          linux-wifi-hotspot
          haveged
        ];

        text = ''
          echo "Enter SSID: "
          read -r ssid

          echo "Enter password: "
          read -r password

          sudo create_ap \
            wlan0 wlan0 \
            "$ssid" "$password" \
            --ieee80211ac \
            --dhcp-dns 1.1.1.1 \
            -w 3
        '';
      };

      sysinfo = "${pkgs.writeScriptBin "sysinfo" ''
        ${pkgs.util-linux}/bin/lscpu
        ${pkgs.pciutils}/bin/lspci -v
        ${pkgs.coreutils}/bin/uname --all
        ${pkgs.fastfetch}/bin/fastfetch
      ''}";
    in
    {
      home.packages = with pkgs; [
        ripgrep
        ripgrep-all
        file

        hotspot
        sysinfo
      ];

      programs.kitty = {
        enable = true;

        settings = {
          touch_scroll_multiplier = 3.0;
          confirm_os_window_close = 0;
        };
      };

      programs.yazi = {
        enable = true;
        settings = {
          mgr = {
            show_hidden = true;
            sort_by = "alphabetical";
            sort_dir_first = true;
          };
        };
      };

      programs = {
        fish.enable = true;
        starship.enable = true;
        fzf.enable = true;
      };

      home.shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        grep = "${pkgs.ripgrep}/bin/rg";
      };
    };
}

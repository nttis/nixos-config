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
    in
    {
      home.packages = with pkgs; [
        bat
        ripgrep
        ripgrep-all
        file

        hotspot
      ];

      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
      };

      programs.kitty = {
        enable = true;

        shellIntegration = {
          enableBashIntegration = true;
          enableFishIntegration = true;
        };

        settings = {
          touch_scroll_multiplier = 3.0;
          confirm_os_window_close = 0;
        };
      };

      programs.yazi = {
        enable = true;
        enableFishIntegration = true;
        enableBashIntegration = true;

        settings = {
          mgr = {
            show_hidden = true;
            sort_by = "alphabetical";
            sort_dir_first = true;
          };
        };
      };

      programs.fish = {
        enable = true;
      };

      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
      };

      home.shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        grep = "${pkgs.ripgrep}/bin/rg";
        bottom = "${pkgs.bottom}/bin/btm --tree";

        sysinfo = "${pkgs.writeScript "sysinfo.sh" ''
          ${pkgs.coreutils}/bin/uname --all
          ${pkgs.util-linux}/bin/lscpu
          ${pkgs.pciutils}/bin/lspci -v
          ${pkgs.fastfetch}/bin/fastfetch
        ''}";
      };
    };
}

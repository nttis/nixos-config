{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    bat
    ripgrep
    ripgrep-all
    file
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

    environment = {
      DISPLAY = ":0";
    };
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "alphabetical";
        sort_dir_first = true;
      };
    };
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "ls" = "${pkgs.eza}/bin/eza";
      "grep" = "${pkgs.ripgrep}/bin/rg";

      "sysinfo" = "${pkgs.writeScript "sysinfo.sh" ''
        ${pkgs.coreutils}/bin/uname --all
        ${pkgs.util-linux}/bin/lscpu
        ${pkgs.pciutils}/bin/lspci -v
        ${pkgs.fastfetch}/bin/fastfetch
      ''}";

      "bottom" = "${pkgs.bottom}/bin/btm --tree";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}

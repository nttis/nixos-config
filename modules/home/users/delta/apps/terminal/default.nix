{
  lib,
  pkgs,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "user-specific terminal stack";
} {
  home.packages = with pkgs; [
    bat
    ripgrep
    ripgrep-all
    file
    xplr
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
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "ls" = "${pkgs.eza}/bin/eza";
      "grep" = "${pkgs.ripgrep}/bin/rg";
      "yazi" = "${pkgs.xplr}/bin/xplr";

      "sysinfo" = "${pkgs.writeScript "sysinfo.sh" ''
        ${pkgs.coreutils}/bin/uname --all
        ${pkgs.util-linux}/bin/lscpu
        ${pkgs.pciutils}/bin/lspci -v
        ${pkgs.fastfetch}/bin/fastfetch
      ''}";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
}

{
  lib,
  config,
  namespace,
  ...
}: {
  options.${namespace}.apps.kitty = {
    enable = lib.mkEnableOption "kitty, the terminal emulator";
  };

  config = lib.mkIf config.${namespace}.apps.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        confirm_os_window_close = 0;
      };
    };
  };
}

{ pkgs, ... }:
let
  wallpapers = pkgs.fetchzip {
    url = "https://files.catbox.moe/w884wb.zip";
    stripRoot = false;
    hash = "sha256-eCNMTl8uLjeiRDbE4biPS71qwyVmi1iGF5hCDdMxMxA=";
  };
in
{
  services.swww.enable = true;

  systemd.user.services.swww-cycle = {
    Unit = {
      Description = "Cycle wallpaper with swww";
    };

    Service = {
      Type = "exec";
      ExecStart = pkgs.writers.writeNu "swww-cycle.nu" ''
        let file = ls ${wallpapers} | shuffle | first | get name | path expand
        ${pkgs.swww}/bin/swww img $file
      '';
    };
  };

  systemd.user.timers.swww-cycle = {
    Unit = {
      Description = "Timer to activate swww-cycle.service";
      After = [ "graphical-session.target" ];
    };

    Timer = {
      OnStartupSec = 5;
      OnUnitActiveSec = 600;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}

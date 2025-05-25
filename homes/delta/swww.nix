{pkgs, ...}: let
  wallpapers = pkgs.fetchzip {
    url = "https://files.catbox.moe/9pcpr3.zip";
    stripRoot = false;
    hash = "sha256-3s7NhcgYy6Np+slHidN3oToD2Rip4e+y/wFQ12tG+KI=";
  };
in {
  services.swww.enable = true;

  systemd.user.services.swww-cycle = {
    Unit = {
      Description = "Cycle wallpaper with swww";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "exec";
      ExecStart = pkgs.writers.writeNu "swww-cycle.nu" ''
        let file = ls ${wallpapers} | shuffle | first | get name | path expand
        ${pkgs.swww}/bin/swww img $file
      '';
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  systemd.user.timers.swww-cycle = {
    Unit = {
      Description = "Timer to activate swww-cycle.service";
      After = ["graphical-session.target"];
    };

    Timer = {
      OnUnitActiveSec = 600;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}

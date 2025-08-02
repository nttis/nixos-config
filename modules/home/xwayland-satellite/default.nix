{pkgs, ...}: {
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Autostart xwayland-satellite";
      After = ["graphical-session.target"];
    };

    Service = {
      Type = "exec";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  home.packages = [
    pkgs.xwayland-satellite
  ];
}

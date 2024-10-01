{
  pkgs,
  inputs,
  ...
}:
let
  rootPath = ./../..;
in

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.ags.homeManagerModules.default

    (rootPath + /home/firefox.nix)
    (rootPath + /home/vscode.nix)
    (rootPath + /home/kitty.nix)
    (rootPath + /home/git.nix)
  ];

  home.username = "delta";
  home.homeDirectory = "/home/delta";

  home.sessionVariables = {
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];

    settings = {
      exec-once = "waybar & kitty";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      cursor = {
        # This singlehandedly fixes all off-center cursor problems
        # god bless
        no_hardware_cursors = true;
      };

      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        resize_on_border = true;
        layout = "master";
      };

      decoration = {
        rounding = 10;
        blur.enabled = false;
      };

      animations = {
        enabled = false;
      };

      bind = [
        "SUPER, C, killactive"
        "SUPER, Q, exec, kitty"
        "SUPER, V, togglefloating"
      ];

      plugin = {
        hyprbars = {
          bar_height = 20;

          hyprbars-button = [
            "rgb(ff4040), 10, , hyprctl dispatch killactive"
            "rgb(eeee11), 10, , hyprctl dispatch fullscreen 1"
          ];
        };
      };
    };
  };

  home.packages = with pkgs; [
    # Desktop apps
    vlc
    mpv
    sublime
    vesktop
    gparted

    # Terminal
    fish

    # CLIs
    ffmpeg-full
    fastfetch

    # Development
    nixd
    nixfmt-rfc-style
  ];

  programs.ags = {
    enable = true;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  # Impermanence stuff
  home.persistence."/persist/delta" = {
    directories = [
      ".ssh"
      ".gnupg"

      ".local/share/keyrings"
      ".local/share/direnv"

      ".local/share/flatpak"
      ".var"

      ".config/vesktop"

      ".mozilla"
    ];
    allowOther = true;
  };

  home.stateVersion = "24.05";
}

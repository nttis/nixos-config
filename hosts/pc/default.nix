# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./boot.nix

    ../common.nix
  ];

  networking.hostName = "pc"; # Define your hostname.

  # Desktop environment
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    konsole
    plasma-browser-integration
    ark
    krdp
    kwalletmanager
    kwallet-pam
    kwallet
    okular
    kate
    kwrited
  ];

  documentation.nixos.enable = false;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  /*
    fonts = {
      enableDefaultPackages = false;

      packages = with pkgs; [
        inter

        fira-code
        fira-code-symbols

        noto-fonts
        noto-fonts-cjk
        noto-fonts-cjk-sans
        noto-fonts-emoji
        noto-fonts-color-emoji

        source-serif

        font-awesome
      ];

      fontconfig = {
        defaultFonts = {
          serif = [
            "Noto Serif"
            "source-serif"
          ];
          sansSerif = [ "Inter" ];
          monospace = [ "FiraCode" ];
        };
      };
    };
  */

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    kitty
    rofi-wayland
    dunst
    waybar
  ];

  # Users
  users.users.delta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialHashedPassword = "$y$j9T$vi.Fiw9MHEijNtyrqt1vF.$d8Ce0EJkAwNGZWYbdaC4ezukqk2D4xkOJ5IB18ykdk4";
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs;
    };
    users = {
      "delta" = import ./../../users/delta;
    };

    useGlobalPkgs = true;
    useUserPackages = true;

    # Impermanence will delete these anyway
    backupFileExtension = "backup";
  };

  # Stylix
  stylix = {
    enable = true;
    polarity = "dark";

    base16Scheme = {
      base00 = "2b3339"; # Default Background
      base01 = "323c41"; # Lighter Background (Used for status bars, line number and folding marks)
      base02 = "503946"; # Selection Background
      base03 = "868d80"; # Comments, Invisibles, Line Highlighting
      base04 = "d3c6aa"; # Dark Foreground (Used for status bars)
      base05 = "d3c6aa"; # Default Foreground, Caret, Delimiters, Operators
      base06 = "e9e8d2"; # Light Foreground (Not often used)
      base07 = "fff9e8"; # Light Background (Not often used)
      base08 = "7fbbb3"; # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
      base09 = "d699b6"; # Integers, Boolean, Constants, XML Attributes, Markup Link Url
      base0A = "83c092"; # Classes, Markup Bold, Search Text Background
      base0B = "dbbc7f"; # Strings, Inherited Class, Markup Code, Diff Inserted
      base0C = "e69875"; # Support, Regular Expressions, Escape Characters, Markup Quotes
      base0D = "a7c080"; # Functions, Methods, Attribute IDs, Headings
      base0E = "e67e80"; # Keywords, Storage, Selector, Markup Italic, Diff Changed
      base0F = "d699b6"; # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
    };
    image = config.lib.stylix.pixel "base0A";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.fira-code;
        name = "Fira Code";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter Medium";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Emoji";
      };
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

{
  pkgs,
  lib,
  options,
  ...
}:
{
  imports = [ ];

  # The setup:
  # - systemd-networkd: manages DHCP
  # - iwd: route wireless connections
  # - systemd-resolved: provides DNS resolution with DNS over TLS

  systemd.network = {
    enable = true;

    # Enable systemd-networkd to manage DHCP for both wired and wireless.
    networks."20-all" = {
      matchConfig = {
        Type = "ether wlan";
      };

      networkConfig = {
        DHCP = "yes";
        IPv6PrivacyExtensions = true;
      };

      dhcpConfig = {
        Anonymize = true;
      };
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
  };

  networking = {
    # Disable all other DHCP clients and DNS resolution services
    useDHCP = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = false;

    useNetworkd = true;

    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          # Don't use iwd's built-in DHCP client because systemd-networkd
          # is already taking care of it
          EnableNetworkConfiguration = false;
        };
        Network = {
          NameResolvingService = "systemd";
        };
      };
    };

    # These nameservers are read by systemd-resolved and is used globally
    nameservers = [
      "1.1.1.1#cloudflare-dns.com"
      "1.0.0.1#cloudflare-dns.com"
    ];

    nftables.enable = true;

    firewall = {
      enable = true;

      # To facilitate hotspot wifi sharing
      allowedUDPPorts = [ 67 ];
      trustedInterfaces = [ "ap0" ];

      # Open common development ports
      allowedTCPPortRanges = [
        {
          from = 8000;
          to = 8080;
        }
      ];

      allowedUDPPortRanges = [
        {
          from = 8000;
          to = 8080;
        }
      ];
    };
  };

  environment = lib.mkMerge [
    {
      systemPackages = [
        pkgs.impala
      ];
    }

    (lib.optionalAttrs (options ? environment.persistence) {
      persistence."/persist/system" = {
        directories = [
          "/var/lib/iwd"
        ];
      };
    })
  ];
}

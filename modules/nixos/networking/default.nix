{
  pkgs,
  lib,
  options,
  ...
}:
{
  imports = [ ];

  # The setup:
  # - systemd-networkd: manages wired connections
  # - iwd: manages wireless connections
  # - dnscrypt-proxy2: DNS resolution and sinkholing

  systemd.network = {
    enable = true;
    wait-online.enable = false;

    networks."60-ether" = {
      matchConfig = {
        Type = "ether";
      };

      networkConfig = {
        DHCP = "yes";
        IgnoreCarrierLoss = "3s";
      };

      dhcpV4Config = {
        UseDNS = false; # Ignore nameservers from DHCP
      };
    };
  };

  services.resolved.enable = lib.mkForce false;

  networking = {
    # Disable all other DHCP clients and DNS resolution services
    useDHCP = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = false;

    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true;
        };
        Network = {
          NameResolvingService = "none";
        };
      };
    };

    nameservers = [
      "127.0.0.1"
      "::1"
    ];

    nftables.enable = true;

    firewall = {
      enable = true;

      # To facilitate hotspot wifi sharing
      allowedUDPPorts = [ 67 ];
      trustedInterfaces = [
        "ap0"
      ];

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

  services.dnscrypt-proxy = {
    enable = true;
    upstreamDefaults = false;
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        refresh_delay = 72;
        prefix = "";
      };

      server_names = [
        "quad9-dnscrypt-ip4-nofilter-pri"
        "quad9-dnscrypt-ip4-nofilter-ecs-pri"
        "quad9-doh-ip4-port443-nofilter-ecs-pri"
        "quad9-doh-ip4-port443-nofilter-pri"
        "cloudflare"
      ];

      bootstrap_resolvers = [
        "9.9.9.9:53"
        "1.1.1.1:53"
        "1.0.0.1:53"
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

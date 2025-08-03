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

    wait-online = {
      enable = false;
    };

    # Let systemd-networkd manage wired/ethernet
    networks."20-wired" = {
      matchConfig = {
        Type = "ether";
      };

      networkConfig = {
        Description = "Wired devices";
        DHCP = "yes";
        IPv6PrivacyExtensions = true;
      };

      dhcpConfig = {
        Anonymize = true;
      };
    };
  };

  networking = {
    # Disable external DHCP clients and DNS resolution services
    useDHCP = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;
    networkmanager.enable = false;

    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          EnableNetworkConfiguration = true; # does DHCP
        };
        Network = {
          NameResolvingService = "none"; # but don't do DNS resolution
        };
      };
    };

    nameservers = [
      "1.1.1.1"
    ];

    nftables.enable = true;

    firewall = {
      enable = true;

      # To facilitate hotspot wifi sharing
      allowedTCPPorts = [ 67 ];
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

  services.dnscrypt-proxy2 = {
    enable = false;

    # Settings reference:
    # https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      ipv4_servers = true;
      ipv6_servers = true;

      dnscrypt_servers = true;
      doh_servers = true;
      odoh_servers = true;

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      cache = true;
      listen_addresses = [ "127.0.0.1:53" ];

      bootstrap_resolvers = [
        "1.1.1.1:53"
        "9.9.9.9:53"
      ];

      # Add this to test if dnscrypt-proxy is actually used to resolve DNS requests
      query_log.file = "/var/log/dnscrypt-proxy/query.log";

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];

        cache_file = "/var/cache/dnscrypt-proxy/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
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

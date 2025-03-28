{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [];

  environment.systemPackages = with pkgs; [
    impala
  ];

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

    netdevs."ap0" = {
      enable = true;

      netdevConfig = {
        Kind = "wlan";
        Name = "ap0";
        MACAddress = "12:34:56:78:9a:bc";
      };

      wlanConfig = {
        PhysicalDevice = 0;
        Type = "ap";
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
          EnableNetworkConfiguration = true; # iwd manages wireless
        };
        Network = {
          NameResolvingService = "none"; # disable DNS resolution
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
    enable = true;

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

      bootstrap_resolvers = ["9.9.9.11:53" "8.8.8.8:53"];

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

  environment.persistence."/persist/system" = lib.mkIf config.impermanence.enable {
    directories = [
      "/var/lib/iwd"
    ];
  };
}

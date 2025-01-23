{
  lib,
  config,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "networking";
} {
  # Behold, the holy trifecta of modern Linux networking: systemd-networkd,
  # ~~systemd-resolved~~ ADGUARD HOME and iwd.
  #
  # systemd-networkd manages devices and interfaces and provide wired networking.
  # iwd provides wireless networking.
  # Adguard-Home provides encrypted DNS and DNS sinkholing.
  systemd.network = {
    enable = true;

    wait-online = {
      enable = true;
      anyInterface = true;
    };

    networks."20-generic" = {
      matchConfig = {
        Type = "ether wlan";
      };

      networkConfig = {
        Description = "Generic network config";
        IgnoreCarrierLoss = "10s";
        DHCP = "yes";
      };

      dhcpV4Config = {
        UseDNS = false;
        Anonymize = true;
      };

      dhcpV6Config = {
        UseDNS = false;
      };
    };
  };

  services.resolved.enable = false;

  networking = {
    # Disable these services because systemd-networkd already
    # manages DHCP
    useDHCP = false;
    dhcpcd.enable = false;
    resolvconf.enable = false;

    wireless = {
      iwd = {
        enable = true;
        settings = {
          General = {
            EnableNetworkConfiguration = true;
            AddressRandomization = "network";
          };

          Network = {
            NameResolvingService = "none";
          };
        };
      };
    };

    nameservers = ["127.0.0.1:53"];
  };

  services.adguardhome = {
    enable = true;
    mutableSettings = false;
    settings = {
      dns = {
        port = 53;
        ratelimit = 0;

        bootstrap_dns = ["1.1.1.1" "9.9.9.9"];
        upstream_mode = "fastest_addr";
        upstream_dns = [
          "https://dns.cloudflare.com/dns-query"
          "tls://one.one.one.one"
        ];

        cache_optimistic = true;
        enable_dnssec = true;
      };

      # Don't have to enable this because we aren't running
      # a public DNS resolver server
      tls = {
        enabled = false;
      };
    };
  };

  environment.persistence."/persist/system" = lib.mkIf config.${namespace}.impermanence.enable {
    directories = [
      {
        directory = "/var/lib/iwd";
        user = "root";
        group = "root";
        mode = "u=rw,g=rw,o=";
      }
    ];
  };
}

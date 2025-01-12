{
  lib,
  config,
  pkgs,
  namespace,
  ...
}:
lib.${namespace}.mkModule ./. config {
  enable = lib.mkEnableOption "networking";
} {
  # iwd acts as the standalone WiFi manager. It is configured to ignore
  # name server resolution obtained from DHCP.
  #
  # Instead, the only nameserver is hardcoded to be 127.0.0.1:53, which is
  # where dnscrypt-proxy2 listens.
  #
  # dnscrypt-proxy2 acts as a local DNS nameserver resolver. It encrypts all
  # outbound DNS requests (from apps, system, etc.) with HTTPS and forward them
  # to capable remote DNS nameservers. It is configured to use cloudflare (1.1.1.1)
  # and fallback to adguard nameserver at the present.

  networking = {
    wireless.iwd = {
      enable = true;

      settings = {
        Network = {
          NameResolvingService = "none";
          EnableIPv6 = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };

    nameservers = ["127.0.0.1" "::1"];
  };

  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"; # See https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
      };

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;

      server_names = ["cloudflare" "adguard"];
    };
  };

  systemd.services.dnscrypt-proxy2.serviceConfig.StateDirectory = "dnscrypt-proxy";

  environment.persistence."/persist/system" = lib.mkIf config.${namespace}.impermanence.enable {
    directories = [
      "/var/lib/iwd"
    ];
  };
}

{ ... }:
{
  flake.modules.nixos.tailscale = {
    services.tailscale.enable = true;

    networking.firewall = {
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  flake.modules.nixos.impermanence = {
    preservation.preserveAt."/persist/system" = {
      directories = [
        "/var/lib/tailscale"
      ];
    };
  };
}

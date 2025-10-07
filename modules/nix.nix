{ ... }:
{
  flake.modules.nixos.nix =
    { pkgs, ... }:
    {
      nix = {
        package = pkgs.nixVersions.latest;
        settings = {
          show-trace = true;
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          flake-registry = "";

          substituters = [
            "https://nttis.cachix.org"
          ];

          trusted-public-keys = [
            "nttis.cachix.org-1:ohXet8jSa6Am+ncf56FgHHfVd0qlqvbPckrGXmE48cs="
          ];
        };
      };
    };
}

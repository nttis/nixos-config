{ ... }:
{
  flake.modules.homeManager."ssh@delta" = {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
    };

    services.ssh-agent = {
      enable = true;
    };
  };

  flake.modules.nixos.impermanence = {
    preservation.preserveAt."/persist".users.delta = {
      directories = [
        {
          directory = ".ssh";
          mode = "0700";
        }
      ];
    };
  };
}

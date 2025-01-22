{
  lib,
  config,
  pkgs,
  namespace,
  ...
}: let
  username = "delta";

  servicesCfg = config.${namespace}.services;

  sopsCfg = lib.mkIf servicesCfg.sops-nix.enable {
    secrets."${username}/ssh_keys/primary" = {
      format = "yaml";
      sopsFile = lib.snowfall.fs.get-snowfall-file "secrets/delta.yaml";
      owner = username;
      key = "ssh_keys/primary";
    };
  };

  persistCfg = lib.mkIf config.${namespace}.impermanence.enable {
    tmpfiles.settings = {
      "${username}-persist" = {
        "/persist/${username}" = {
          d = {
            user = "${username}";
            mode = "700";
          };
        };
      };

      "${username}-nixos-permission" = {
        "/persist/nixos" = {
          Z = {
            user = "${username}";
            mode = "700";
          };
        };
      };
    };
  };

  sshCfg = lib.mkIf (servicesCfg.ssh-client.enable && servicesCfg.sops-nix.enable) {
    user.services."ssh-add" = {
      enable = true;
      wantedBy = ["default.target"];

      # NixOS makes a systemd service called ssh-agent.service
      # to autostart ssh-agent on login
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/nixos/modules/programs/ssh.nix#L312
      after = ["ssh-agent.service"];
      requires = ["ssh-agent.service"];

      environment = {
        SSH_ASKPASS_REQUIRE = "force";
        SSH_ASKPASS = "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass";
      };

      serviceConfig = {
        ExecStart = ''
          ${pkgs.openssh}/bin/ssh-add \
            /run/secrets/${username}/ssh_keys/primary
        '';

        Restart = "on-failure";
        RestartSec = "3s";
      };
    };
  };
in
  lib.${namespace}.mkModule ./. config {
    enable = lib.mkEnableOption "user: ${username}";
  } {
    users.users.${username} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      initialHashedPassword = "$y$j9T$vi.Fiw9MHEijNtyrqt1vF.$d8Ce0EJkAwNGZWYbdaC4ezukqk2D4xkOJ5IB18ykdk4";
    };

    sops = sopsCfg;
    systemd = persistCfg // sshCfg;
  }

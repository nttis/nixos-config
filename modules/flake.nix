{ self, inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  flake.githubActions = inputs.nix-github-actions.lib.mkGithubMatrix {
    checks = inputs.nixpkgs.lib.getAttrs [ "x86_64-linux" ] self.checks;
  };
}

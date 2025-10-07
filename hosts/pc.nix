{ self, inputs, ... }:
{
  flake.nixosConfigurations.pc = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [ self.modules.nixos."hosts.pc" ];
  };
}

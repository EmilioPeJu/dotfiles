{
  description = "Emilio's system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    epnix.url = "github:epics-extensions/EPNix";
  };

  outputs = inputs@{ self, nixpkgs, epnix, ... }:
  {
    nixosConfigurations = {
      vivobook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
           { _module.args = inputs; }
          ./hosts/vivobook-s-14/configuration.nix
        ];
      };
      livecd = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
           { _module.args = inputs; }
          ./hosts/livecd/configuration.nix
        ];
      };
      trigkey = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
           { _module.args = inputs; }
          ./hosts/trigkey-s7/configuration.nix
        ];
      };
    };
  };
}

{ config, pkgs, ... }:

let dirty = (import ../dirty.nix { });
in {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
    ./../base.nix
    ./../desktop.nix
  ];
  networking.hostName = "machine";
  networking.networkmanager.enable = false;
  # users
  users.users = {
    nixos = {
      uid = 1001;
      extraGroups = [ "dialout" ];
    };
    root = { hashedPassword = dirty.rootHash; };
  };
}


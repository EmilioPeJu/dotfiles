{ config, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../../minimal-base.nix
    ../../user.nix
  ];
  networking.hostName = "livecd";
}


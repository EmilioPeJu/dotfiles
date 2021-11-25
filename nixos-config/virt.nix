{ config, lib, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  users.users.user.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [ qemu ];
}

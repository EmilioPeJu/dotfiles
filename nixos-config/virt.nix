{ config, lib, pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.users.user.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    qemu
  ];
}

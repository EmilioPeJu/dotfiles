{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  users.users.user.extraGroups = [ "docker" "libvirtd" ];
  virtualisation.docker.storageDriver = "zfs";
  environment.systemPackages = with pkgs; [
    devcontainer
    distrobox
    #firectl
    virt-manager
    docker-compose
  ];
}

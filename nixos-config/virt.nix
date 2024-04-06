{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true; # virt-manager requires dconf to remember settings
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  users.users.user.extraGroups = [ "docker" "libvirtd" ];
  environment.systemPackages = with pkgs; [
    distrobox
    #firectl
    virt-manager
  ];
}

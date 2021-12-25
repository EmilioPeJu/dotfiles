{ config, lib, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  users.users.user.extraGroups = [ "docker" "vboxusers" ];
  environment.systemPackages = with pkgs; [ qemu ];
}

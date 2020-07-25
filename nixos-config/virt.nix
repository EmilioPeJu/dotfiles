{ config, lib, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    # VM
    qemu
  ];
}

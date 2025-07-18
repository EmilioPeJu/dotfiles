{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  # virt-manager requires dconf to remember settings
  programs.dconf.enable = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  users.users.user.extraGroups = [ "docker" "libvirtd" ];
  #networking.firewall.allowedTCPPorts = [
  #  6443 # k3s API server
  #];
  #services.k3s = {
  #  enable = true;
  #  role = "server";
  #  extraFlags = toString [
  #    #"--debug"
  #  ];
  #};
  #virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "user" ];
  environment.systemPackages = with pkgs; [
    devcontainer
    distrobox
    docker-compose
    #firectl
    #kind
    kubectl
    #kubernetes-helm
    minikube
    podman
    virt-manager
    virtiofsd
  ];
}

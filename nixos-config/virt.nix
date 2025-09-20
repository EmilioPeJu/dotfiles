{ config, lib, pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    allowedBridges = [ "brvirt" ];
  };
  virtualisation.spiceUSBRedirection.enable = true;
  # virt-manager requires dconf to remember settings
  programs.dconf.enable = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  users.users.user.extraGroups = [
    "docker"
    "libvirtd"
    "kvm"
    "qemu-libvirtd"
  ];
  # VFIO for PCIe passthrough
  boot.kernelModules = [ "vfio-pci" ];
  boot.kernelParams = [
    "amd_iommu=on"
  ];
  services.udev.extraRules = ''
    SUBSYSTEM=="vfio", GROUP="kvm", MODE="0770"
  '';
  environment.systemPackages = with pkgs; [
    devcontainer
    distrobox
    docker-compose
    #firectl
    #kind  # alternative to k3s(lighter)
    kubectl
    kvmtool
    #kubernetes-helm
    minikube
    #podman
    virt-manager
    virtiofsd
  ];
}

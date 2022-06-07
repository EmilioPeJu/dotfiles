{ config, lib, pkgs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  users.users.user.extraGroups = [ "docker" "vboxusers" ];
  environment.systemPackages = with pkgs; [
    cni
    cni-plugins
    containerd
    nerdctl
    qemu
    runc
  ];

  networking.interfaces.tap0 = {
    virtual = true;
    virtualOwner = "user";
    ipv4.addresses = [
      {
        address = "172.16.0.1";
        prefixLength = 16;
      }
    ];
  };

  # NFS server to let VMs use /nix software
  services.nfs.server = {
    enable = true;
    exports = ''
      /nix 172.16.0.0/16(rw,sync,no_subtree_check)
      /home/user/src 172.16.0.0/16(rw,sync,no_subtree_check)
    '';
    lockdPort = 4001;
  };

  networking = {
    firewall.allowedTCPPorts = [ 111 2049 4001 4045 20048 ];
    firewall.allowedUDPPorts = [ 111 2049 4001 4045 20048 ];
  };


}

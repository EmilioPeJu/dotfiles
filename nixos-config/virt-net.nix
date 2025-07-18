{ config, lib, pkgs, ... }:

{
  networking.interfaces.tap0 = {
    virtual = true;
    virtualOwner = "user";
    ipv4.addresses = [{
      address = "172.16.0.1";
      prefixLength = 16;
    }];
  };

  # NFS server to let VMs use /nix software
  services.nfs.server = {
    enable = true;
    exports = ''
      /nix 172.16.0.0/16(ro,sync,no_subtree_check)
    '';
    lockdPort = 4001;
  };

  networking = {
    firewall.allowedTCPPorts = [ 111 2049 4001 4045 20048 ];
    firewall.allowedUDPPorts = [ 111 2049 4001 4045 20048 ];
  };
}

{ config, lib, pkgs, ... }:

{
  networking.bridges = {
    "brvirt" = {
        interfaces = [ "tapvirt" ];
    };
  };
  networking.interfaces.brvirt.ipv4.addresses = [{
    address = "172.18.0.1";
    prefixLength = 24;
  }];
  networking.interfaces.tapvirt = {
    virtual = true;
    virtualOwner = "user";
  };
  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "brvirt";
      dhcp-range = [ "172.18.0.3,172.18.0.254" ];
    };
  };
  networking = {
    firewall.allowedTCPPorts = [ 67 68 ];
    firewall.allowedUDPPorts = [ 67 68 ];
  };
}

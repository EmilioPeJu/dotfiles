{ config, lib, pkgs, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [ 1234 5064 6064 5065 6065 5075 6075 7011 7012 ];
    allowedUDPPorts = [ 5064 6064 5065 6065 5076 ];
  };
}

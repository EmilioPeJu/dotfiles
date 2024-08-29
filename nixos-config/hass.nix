{ config, pkgs, lib, ... }:

let dirty = (import ./dirty.nix { });
in {
  networking.firewall.allowedTCPPorts = [ 8123 ];
  services.home-assistant = {
    enable = true;
    config = {
      default_config = {};
      # Smart bulbs
      #lifx.light = [{ broadcast = "192.168.100.2"; }];
    };
  };
}

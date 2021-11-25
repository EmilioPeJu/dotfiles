{ config, pkgs, lib, ... }:

let dirty = (import ./dirty.nix { });
in {
  services.hostapd = {
    enable = true;
    interface = "wlan0";
    ssid = dirty.ssid;
    wpaPassphrase = dirty.wpaPassphrase;
  };

  networking.firewall.allowedUDPPorts = [ 53 67 ];
  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      # dns
      server = 8.8.8.8
      # focus on wlan0, using interface options
      # is less flexible
      no-dhcp-interface=eth0
      dhcp-range=192.168.100.128,192.168.100.254,12h
      # default gateway
      dhcp-option=3,192.168.100.1
      # dns servers
      dhcp-option=6,8.8.8.8
      # L1
      dhcp-host=d0:73:d5:58:0d:fb,192.168.100.2
    '';
  };
}

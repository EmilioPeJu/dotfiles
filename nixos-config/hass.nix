{ config, pkgs, lib, ... }:

let dirty = (import ./dirty.nix { });
in {
  networking.firewall.allowedTCPPorts = [ 8123 ];
  services.home-assistant = {
    enable = true;
    config = {
      homeassistant = {
        http.server_port = 8123;
        name = "Home";
        time_zone = "Europe/London";
        latitude = dirty.latitude;
        longitude = dirty.longitude;
        elevation = dirty.elevation;
        unit_system = "metric";
        temperature_unit = "C";
      };
      # Enable the frontend
      frontend = { };
      http = { };
      # Smart bulbs
      lifx.light = [{ broadcast = "192.168.100.2"; }];
    };
  };
}

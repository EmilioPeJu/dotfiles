{ config, pkgs, lib, ... }:

{
  networking.firewall.allowedTCPPorts = [ 8123 ];
  services.home-assistant = {
    enable = true;
    port = 8123;
    config = {
      homeassistant = {
        name = "Home";
        time_zone = "Europe/London";
        latitude = 1;
        longitude = 1;
        elevation = 1;
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

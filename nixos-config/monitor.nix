{ config, lib, pkgs, ... }:

{
  services.prometheus.exporters = {
    node = {
      enable = true;
      enabledCollectors = ["systemd"];
    };
  };
}

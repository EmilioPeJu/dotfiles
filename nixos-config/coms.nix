{ config, lib, pkgs, ... }:

{
  hardware.hackrf.enable = true;
  environment.systemPackages = with pkgs; [
    gnuradio
  ];
}

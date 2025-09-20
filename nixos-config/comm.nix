{ config, lib, pkgs, ... }:

{
  hardware.hackrf.enable = true;
  hardware.rtl-sdr.enable = true;
  services.avahi.enable = true;
  services.yggdrasil.enable = true;
  environment.systemPackages = with pkgs; [
    audacity
    chirp
    gnuradio
    grig
    gqrx
    inspectrum
    libiio
    rtl_433
    sdrpp
    soapysdr-with-plugins
  ];
}

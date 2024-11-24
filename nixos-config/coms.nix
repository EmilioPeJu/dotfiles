{ config, lib, pkgs, ... }:

{
  hardware.hackrf.enable = true;
  environment.systemPackages = with pkgs; [
    audacity
    gnuradioMinimal
    inspectrum
    rtl_433
    urh
  ];
}

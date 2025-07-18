{ config, lib, pkgs, ... }:

{
  hardware.hackrf.enable = true;
  hardware.rtl-sdr.enable = true;
  environment.systemPackages = with pkgs; [
    audacity
    (gnuradio.override {
      extraPackages = with gnuradioPackages; [
        lora_sdr
        osmosdr
      ];
      extraPythonPackages = with gnuradio.python.pkgs; [
        numpy
      ];
    })
    inspectrum
    rtl_433
    #urh
  ];
}

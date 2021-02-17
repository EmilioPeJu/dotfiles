{ config, pkgs, ... }:

let 
  minipro = pkgs.callPackage ./pkgs/minipro {};
in
{
  environment.systemPackages = with pkgs; [
    arduino
    avrdude
    flashrom
    gcc-arm-embedded
    geda
    kicad
    minipro
    mynewt-newt
    ngspice
    nrfutil
    openocd
    picocom
    pulseview
    #qmk_firmware
    sigrok-cli
    stlink
  ];
  services.udev.packages = [ minipro ];
}

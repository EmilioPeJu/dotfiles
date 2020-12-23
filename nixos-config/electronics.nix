{ config, pkgs, ... }:

let 
  minipro = pkgs.callPackage ./pkgs/minipro {};
in
{
  environment.systemPackages = with pkgs; [
    arduino
    avrdude
    flashrom
    geda
    kicad
    minipro
    ngspice
    picocom
    pulseview
    #qmk_firmware
    sigrok-cli
  ];
  services.udev.packages = [ minipro ];
}

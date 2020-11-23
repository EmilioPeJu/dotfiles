{ config, pkgs, ... }:

let 
  minipro = pkgs.callPackage ./pkgs/minipro {};
in
{
  environment.systemPackages = with pkgs; [
    arduino
    avrdude
    flashrom
    #kicad
    minipro
    ngspice
    picocom
    pulseview
    sigrok-cli
  ];
  services.udev.packages = [ minipro ];
}

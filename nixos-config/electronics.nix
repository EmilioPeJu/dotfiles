{ config, pkgs, ... }:

let 
  minipro = pkgs.callPackage ./pkgs/minipro {};
in
{
  services.udev.extraRules = ''
    # st-link device
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", GROUP="dialout"
  '';
  environment.systemPackages = with pkgs; [
    arduino
    avrdude
    flashrom
    gcc-arm-embedded
    geda
    kicad
    libftdi
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

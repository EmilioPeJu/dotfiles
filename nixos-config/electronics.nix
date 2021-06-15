{ config, pkgs, ... }:

let 
  minipro = pkgs.callPackage ./pkgs/minipro {};
in
{
  services.udev.extraRules = ''
    # st-link device
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", GROUP="dialout"
    # Xilinx FTDI
    ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Xilinx", GROUP="dialout"
    # Diligent USB
    ATTR{idVendor}=="1443", GROUP="dialout"
    ATTR{idVendor}=="0403", GROUP="dialout"
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

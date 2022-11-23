{ config, pkgs, ... }:

let
  minipro = pkgs.callPackage ./pkgs/minipro { };
  ftdi_eeprom = pkgs.callPackage ./pkgs/ftdi_eeprom { };
  pynus = (pkgs.python3Packages.callPackage ./pkgs/pynus { });
in {
  services.udev.extraRules = ''
    # st-link device
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="374b", GROUP="dialout"
    # Xilinx FTDI
    ACTION=="add", ATTR{idVendor}=="0403", ATTR{manufacturer}=="Xilinx", GROUP="dialout"
    # Diligent USB
    ATTR{idVendor}=="1443", GROUP="dialout"
    ATTR{idVendor}=="0403", GROUP="dialout"
    # Segger
    ATTR{idVendor}=="1366", GROUP="dialout"
    # ST-Link
    ATTR{idVendor}=="0483", GROUP="dialout"
  '';
  environment.systemPackages = with pkgs; [
    #arachne-pnr
    arduino
    avrdude
    #blackmagic
    flashrom
    ftdi_eeprom
    gcc-arm-embedded
    geda
    ghdl
    gtkwave
    #icestorm
    kicad
    libftdi1
    minipro
    ngspice
    #nrfutil
    openocd
    picocom
    #(python3Packages.callPackage ./pkgs/hdl_checker {
    #  pygls = (python3Packages.callPackage ./pkgs/oldpygls { });
    #})
    pulseview
    pyocd
    #qmk_firmware
    pynus
    sigrok-cli
    stlink
    #uhubctl
    #yosys
    #yosys-ghdl
  ];
  services.udev.packages = [ minipro ];
}

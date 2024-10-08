{ config, pkgs, ... }:

let
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
    # Voyager
    ATTRS{idVendor}=="3297", GROUP="plugdev", MODE="0660", SYMLINK+="ignition_dfu"
  '';
  environment.systemPackages = with pkgs; [
    #arachne-pnr
    arduino
    avrdude
    #blackmagic
    dfu-util
    flashrom
    ftdi_eeprom
    gcc-arm-embedded
    geda
    ghdl
    gtkwave
    #icestorm
    logisim
    logisim-evolution
    keymapp
    kicad
    libftdi1
    minipro
    ngspice
    #nrfutil
    openboardview
    openocd
    picocom
    #(python3Packages.callPackage ./pkgs/hdl_checker {
    #  pygls = (python3Packages.callPackage ./pkgs/oldpygls { });
    #})
    #pulseview
    pyocd
    qmk
    pynus
    saleae-logic-2
    sigrok-cli
    stlink
    #uhubctl
    #yosys
    #yosys-ghdl
  ];
  services.udev.packages = [ minipro ];
}

{ config, pkgs, ... }:

{
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
    arduino
    avrdude
    #blackmagic
    dfu-util
    flashprog
    #flashrom
    #ftdi_eeprom
    gcc-arm-embedded
    geda
    gtkwave
    iverilog
    logisim
    logisim-evolution
    keymapp
    kicad
    klayout
    libftdi1
    magic-vlsi
    minipro
    ngspice
    #nrfutil
    openboardview
    openocd
    picocom
    #pulseview
    pyocd
    qmk
    #pynus
    saleae-logic-2
    sby
    sigrok-cli
    stlink
    #uhubctl
    # ======================== FPGA ========================
    #arachne-pnr
    #icestorm
    ghdl
    nvc
    vhdeps
    #yices
    #(yosys.withPlugins (with yosys.allPlugins; [
    #    ghdl
    #]))
  ];
}

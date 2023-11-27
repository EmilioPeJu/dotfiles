{ config, lib, pkgs, ... }:

{
  #boot.kernelPackages = pkgs.linuxPackages-rt;
  boot.kernelPackages = pkgs.linuxModPackages;
  environment.systemPackages = [ pkgs.linuxModPackages.kernel.dev ];

  nixpkgs.config.packageOverrides = pkgs: {
    linuxModPackages = pkgs.linuxPackagesFor (pkgs.linux.override {
      features = {
        debug = true;
      };
      structuredExtraConfig = with lib.kernel; {
        # Debug related (this is provided by debug feature)
        #DEBUG_INFO = yes;
        #DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT = yes;
        #GDB_SCRIPTS = yes;
        # Let me access /dev/mem properly
        STRICT_DEVMEM = no;
        # PCIe related
        PCIE_DPC = yes;
        PCIEAER = yes;
        PCI_DEBUG = yes;
      };
      # workaround for unused option error
      ignoreConfigErrors = true;
     });
  };
}

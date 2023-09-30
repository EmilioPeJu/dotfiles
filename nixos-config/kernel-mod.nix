{ config, pkgs, ... }:

{
  #boot.kernelPackages = pkgs.linuxPackages-rt;

  # Modified Linux
  boot.kernelPatches = [
    #{
    #  name = "Debug options";
    #  patch = null;
    #  extraConfig = ''
    #    DEBUG_INFO y
    #    KGDB y
    #    GDB_SCRIPTS y
    #  '';
    #}
    {
      name = "PCIe options";
      patch = null;
      extraConfig = ''
        PCIE_DPC y
        PCIEAER y
        PCI_DEBUG y
      '';
    }
  ];
}

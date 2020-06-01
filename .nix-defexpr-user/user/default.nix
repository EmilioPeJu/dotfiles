{pkgs ? import <nixpkgs> {}}:
with pkgs;
rec {
  buildEpicsModule = callPackage ./dls-epics-modules/generic { inherit dls-epics patch-configure; };
  dls-epics = callPackage ./dls-epics {};
  patch-configure = callPackage ./patch-configure {};
  dls-epics-sscan = callPackage ./dls-epics-sscan { inherit buildEpicsModule; };
  dls-epics-calc = callPackage ./dls-epics-calc { inherit buildEpicsModule; };
  dls-epics-asyn = callPackage ./dls-epics-asyn { inherit buildEpicsModule; };
  dls-epics-busy = callPackage ./dls-epics-busy { inherit buildEpicsModule dls-epics-asyn; };
}

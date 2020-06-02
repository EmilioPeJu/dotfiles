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
  dls-epics-adsupport = callPackage ./dls-epics-adsupport { inherit buildEpicsModule; };
  dls-epics-pvcommon = callPackage ./dls-epics-pvcommon { inherit buildEpicsModule; };
  dls-epics-pvdata = callPackage ./dls-epics-pvdata { inherit buildEpicsModule dls-epics-pvcommon; };
  dls-epics-normativetypes = callPackage ./dls-epics-normativetypes { inherit buildEpicsModule dls-epics-pvcommon dls-epics-pvdata; };
  dls-epics-pvaccess = callPackage ./dls-epics-pvaccess { inherit buildEpicsModule dls-epics-pvcommon dls-epics-pvdata; };
  dls-epics-pvdatabase = callPackage ./dls-epics-pvdatabase { inherit buildEpicsModule dls-epics-pvcommon dls-epics-pvdata dls-epics-pvaccess; };
  dls-epics-pvaclient = callPackage ./dls-epics-pvaclient { inherit buildEpicsModule dls-epics-pvdata dls-epics-normativetypes dls-epics-pvaccess; };
  dls-epics-adcore = callPackage ./dls-epics-adcore { inherit buildEpicsModule dls-epics-asyn dls-epics-busy dls-epics-sscan dls-epics-calc dls-epics-adsupport dls-epics-pvdata dls-epics-normativetypes dls-epics-pvaccess dls-epics-pvdatabase; };
  dls-epics-adsimdetector = callPackage ./dls-epics-adsimdetector { inherit buildEpicsModule dls-epics-asyn dls-epics-adcore; };
  dls = buildEnv {
    name = "dls";
    paths = [dls-epics patch-configure dls-epics-sscan dls-epics-asyn dls-epics-busy dls-epics-busy dls-epics-adsupport ];
  };
}

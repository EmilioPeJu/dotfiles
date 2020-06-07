{ pkgs ? import (fetchTarball
  "https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz") { } }:
with pkgs; rec {
  buildEpicsModule = callPackage ./dls-epics-modules/generic {
    inherit dls-epics-base patch-configure;
  };
  dls-epics-base = callPackage ./dls-epics-base { };
  patch-configure = callPackage ./patch-configure { };
  hdf5_filters = callPackage ./hdf5_filters { };
  edm = callPackage ./edm { inherit dls-epics-base patch-configure; };
  dls-epics-sscan = callPackage ./dls-epics-sscan { inherit buildEpicsModule; };
  dls-epics-calc = callPackage ./dls-epics-calc { inherit buildEpicsModule; };
  dls-epics-asyn = callPackage ./dls-epics-asyn { inherit buildEpicsModule; };
  dls-epics-busy =
    callPackage ./dls-epics-busy { inherit buildEpicsModule dls-epics-asyn; };
  dls-epics-adsupport =
    callPackage ./dls-epics-adsupport { inherit buildEpicsModule; };
  dls-epics-pvcommon =
    callPackage ./dls-epics-pvcommon { inherit buildEpicsModule; };
  dls-epics-pvdata = callPackage ./dls-epics-pvdata {
    inherit buildEpicsModule dls-epics-pvcommon;
  };
  dls-epics-normativetypes = callPackage ./dls-epics-normativetypes {
    inherit buildEpicsModule dls-epics-pvcommon dls-epics-pvdata;
  };
  dls-epics-pvaccess = callPackage ./dls-epics-pvaccess {
    inherit buildEpicsModule dls-epics-pvcommon dls-epics-pvdata;
  };
  dls-epics-pvdatabase = callPackage ./dls-epics-pvdatabase {
    inherit buildEpicsModule dls-epics-pvcommon dls-epics-pvdata
      dls-epics-pvaccess;
  };
  dls-epics-pvaclient = callPackage ./dls-epics-pvaclient {
    inherit buildEpicsModule dls-epics-pvdata dls-epics-normativetypes
      dls-epics-pvaccess;
  };
  dls-epics-adcore = callPackage ./dls-epics-adcore {
    inherit buildEpicsModule dls-epics-asyn dls-epics-busy dls-epics-sscan
      dls-epics-calc dls-epics-adsupport dls-epics-pvdata
      dls-epics-normativetypes dls-epics-pvaccess dls-epics-pvdatabase
      hdf5_filters;
  };
  dls-epics-adsimdetector = callPackage ./dls-epics-adsimdetector {
    inherit buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-ffmpegserver = callPackage ./dls-epics-ffmpegserver {
    inherit buildEpicsModule dls-epics-asyn dls-epics-adcore
      dls-epics-adsimdetector;
  };
  dls-epics-aravisgige = callPackage ./dls-epics-aravisgige {
    inherit buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-streamdevice = callPackage ./dls-epics-streamdevice {
    inherit buildEpicsModule dls-epics-asyn;
  };
  dls-epics-pvlogging =
    callPackage ./dls-epics-pvlogging { inherit buildEpicsModule; };
  dls-epics-adpython = callPackage ./dls-epics-adpython {
    inherit buildEpicsModule dls-epics-asyn dls-epics-adcore;
  };
  dls-epics-gensub =
    callPackage ./dls-epics-gensub { inherit buildEpicsModule; };
  dls-epics-seq = callPackage ./dls-epics-seq { inherit buildEpicsModule; };
  dls-epics-motor = callPackage ./dls-epics-motor {
    inherit buildEpicsModule dls-epics-busy dls-epics-asyn;
  };
  dls-epics-pmac = callPackage ./dls-epics-pmac {
    inherit buildEpicsModule dls-epics-calc dls-epics-busy dls-epics-asyn
      dls-epics-motor;
  };
  dls_ade = python3Packages.callPackage ./dls_ade { inherit pygelf; };
  pygelf = python3Packages.callPackage ./pygelf { };
  dls_dependency_tree =
    python3Packages.callPackage ./dls_dependency_tree { inherit dls_ade; };
  dls_edm = python3Packages.callPackage ./dls_edm { };
  iocbuilder = python3Packages.callPackage ./iocbuilder {
    inherit dls-epics-base dls_dependency_tree dls_edm;
  };
  dls-python = python3.withPackages
    (pp: with pp; [ dls_ade dls_dependency_tree dls_edm iocbuilder ]);
  dls = buildEnv {
    name = "dls";
    ignoreCollisions = true;
    pathsToLink = [ "/bin" ];
    paths = [
      perl
      dls-epics-base
      patch-configure
      dls-epics-sscan
      dls-epics-asyn
      dls-epics-busy
      dls-epics-busy
      dls-epics-adsupport
      dls-epics-adcore
      dls-epics-adsimdetector
      dls-epics-pvcommon
      dls-epics-pvdata
      dls-epics-pvaccess
      dls-epics-normativetypes
      dls-epics-pvaclient
      dls-epics-ffmpegserver
      dls-epics-aravisgige
      dls-epics-streamdevice
      dls-epics-pvlogging
      dls-epics-adpython
      dls-epics-gensub
      dls-epics-seq
      dls-epics-motor
      dls-epics-pmac
      edm
      dls-python
    ];
    postBuild = ''
      mv $out/bin/python $out/bin/dls-python
      rm $out/bin/py*
    '';
  };
}

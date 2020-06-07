{ readline, libxml2, yasm, buildEpicsModule, dls-epics-asyn, dls-epics-adcore
, dls-epics-adsimdetector }:

buildEpicsModule {
  name = "dls-epics-ffmpegserver";
  buildInputs = [
    readline
    libxml2.dev
    yasm
    dls-epics-asyn
    dls-epics-adcore
    dls-epics-adsimdetector
  ];
  patches = [ ./dont-build-yasm.patch ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/ffmpegServer";
    ref = "dls-master";
  };
}

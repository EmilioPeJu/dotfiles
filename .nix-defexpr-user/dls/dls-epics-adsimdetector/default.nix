{ libxml2, buildEpicsModule, dls-epics-asyn, dls-epics-adcore }:

buildEpicsModule {
  name = "dls-epics-adsimdetector";
  buildInputs = [ libxml2 dls-epics-asyn dls-epics-adcore ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/adsimdetector";
    ref = "dls-master";
  };
}

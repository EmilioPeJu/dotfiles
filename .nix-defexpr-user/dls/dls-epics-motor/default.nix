{ buildEpicsModule, dls-epics-busy, dls-epics-asyn }:

buildEpicsModule {
  name = "dls-epics-motor";
  buildInputs = [ dls-epics-busy dls-epics-asyn ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/motor";
    ref = "dls-master";
  };
  patches = [ ./no-cross-compile.patch ];
}

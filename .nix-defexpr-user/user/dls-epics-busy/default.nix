{ buildEpicsModule, dls-epics-asyn }:

buildEpicsModule {
  name = "dls-epics-busy";
  version = "1";
  buildInputs = [ dls-epics-asyn ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/busy";
    ref = "dls-master";
  };
}

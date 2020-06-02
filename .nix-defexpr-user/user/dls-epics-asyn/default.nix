{ buildEpicsModule, doxygen }:

buildEpicsModule {
  name = "dls-epics-asyn";
  buildInputs = [ doxygen ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/asyn";
    ref = "dls-master";
  };
}

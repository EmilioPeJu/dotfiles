{ buildEpicsModule, doxygen }:

buildEpicsModule {
  name = "dls-epics-asyn";
  version = "4";
  buildInputs = [ doxygen ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/asyn";
    ref = "dls-master";
  };
  meta = {
    priority = 4;
  };
}

{ buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-calc";
  version = "2";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/calc";
    ref = "dls-master";
  };
}

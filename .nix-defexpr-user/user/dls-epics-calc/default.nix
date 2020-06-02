{ buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-calc";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/calc";
    ref = "dls-master";
  };
}

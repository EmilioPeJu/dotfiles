{ buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-pvlogging";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/pvlogging";
    ref = "master";
  };
}

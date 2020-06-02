{ buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-sscan";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/sscan";
    ref = "dls-master";
  };
}

{ buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-sscan";
  version = "2";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/sscan";
    ref = "dls-master";
  };
  meta = {
   priority = 4;
  };
}

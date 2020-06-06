{ buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-gensub";
  patches = [ ./fix-build.patch ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/genSub";
    ref = "master";
  };
}

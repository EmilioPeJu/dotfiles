{ re2c, buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-seq";
  buildInputs = [ re2c ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/seq";
    ref = "dls-master";
  };
}

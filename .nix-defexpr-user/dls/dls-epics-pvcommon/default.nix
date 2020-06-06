{ buildEpicsModule }:

buildEpicsModule rec {
  name = "dls-epics-pvcommon";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/pvcommoncpp";
    ref = "dls-master";
  };
}

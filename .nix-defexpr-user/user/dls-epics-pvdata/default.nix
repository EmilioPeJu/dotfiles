{ buildEpicsModule, dls-epics-pvcommon }:

buildEpicsModule rec {
  name = "dls-epics-pvdata";
  buildInputs = [ dls-epics-pvcommon ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/pvdatacpp";
    ref = "dls-master";
  };
}

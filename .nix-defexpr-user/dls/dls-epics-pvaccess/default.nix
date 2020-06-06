{ buildEpicsModule, dls-epics-pvcommon, dls-epics-pvdata }:

buildEpicsModule rec {
  name = "dls-epics-pvaccess";
  buildInputs = [ dls-epics-pvcommon dls-epics-pvdata ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/pvaccesscpp";
    ref = "dls-master";
  };
}

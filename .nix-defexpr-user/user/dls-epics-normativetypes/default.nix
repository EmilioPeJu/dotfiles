{ buildEpicsModule, dls-epics-pvcommon, dls-epics-pvdata }:

buildEpicsModule rec {
  name = "dls-epics-normativetypes";
  buildInputs = [ dls-epics-pvcommon dls-epics-pvdata ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/normativetypescpp";
    ref = "dls-master";
  };
}

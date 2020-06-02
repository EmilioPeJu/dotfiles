{ buildEpicsModule, dls-epics-pvcommon, dls-epics-pvdata, dls-epics-pvaccess }:

buildEpicsModule rec {
  name = "dls-epics-pvdatabase";
  buildInputs = [ dls-epics-pvcommon dls-epics-pvdata dls-epics-pvaccess ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/pvdatabasecpp";
    ref = "dls-master";
  };
}

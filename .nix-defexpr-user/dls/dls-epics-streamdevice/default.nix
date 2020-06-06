{ readline, buildEpicsModule, dls-epics-asyn }:

buildEpicsModule {
  name = "dls-epics-streamdevice";
  buildInputs = [ readline dls-epics-asyn ];
  patches = [ ./fix-build.patch ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/streamdevice";
    ref = "dls-master";
  };
}

{ buildPythonPackage, dls-epics-base, qt5, pyqt5, dls_dependency_tree, dls_edm
}:
buildPythonPackage rec {
  pname = "iocbuilder";
  version = "3";
  patches = [ ./fix-undefined-symbols.patch ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/iocbuilder";
    ref = "python3";
  };
  postInstall = ''
    cp -rf iocbuilder/defaults $(toPythonPath $out)/iocbuilder
  '';
  buildInputs = [ dls-epics-base ];
  propagatedBuildInputs =
    [ qt5.full pyqt5 dls-epics-base dls_dependency_tree dls_edm ];
}

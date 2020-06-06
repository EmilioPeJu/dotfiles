{ buildPythonPackage, qt5, pyqt5, dls_ade }:
buildPythonPackage rec {
  pname = "dls_dependency_tree";
  version = "2.17";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/dls_dependency_tree";
    ref = "python3";
  };
  preBuild = ''
    sed -i "s/== .\+//g" setup.cfg
    rm Pipfile*
  '';
  postInstall = ''
    cp dls_dependency_tree/*.ui $(toPythonPath $out)/dls_dependency_tree
  '';
  propagatedBuildInputs = [ qt5.full pyqt5 dls_ade ];
}

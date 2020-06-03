{ buildPythonPackage }:
buildPythonPackage rec {
  pname = "dls_edm";
  version = "1";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/dls_edm";
    ref = "python3";
  };
}

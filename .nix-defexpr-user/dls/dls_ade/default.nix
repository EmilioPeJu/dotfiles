{ buildPythonPackage, pytestrunner, six, packaging, distro, python-gitlab
, cookiecutter, pygelf, ldap, GitPython }:
buildPythonPackage rec {
  pname = "dls_ade";
  version = "4";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/dls_ade";
    ref = "master";
  };
  preBuild = ''
    sed -i "s/==[^\']\+//g" setup.py
  '';
  postPatch = ''
    find dls_ade  -not -path "dls_ade/dlsbuild_scripts*" -not -type d -exec \
      patchShebags {} \;
  '';
  doCheck = false;
  # there are unsupported shebags
  # bin/* is patched even with this option
  dontPatchShebangs = 1;
  buildInputs = [ pytestrunner ];
  propagatedBuildInputs =
    [ six packaging distro python-gitlab cookiecutter pygelf ldap GitPython ];
}

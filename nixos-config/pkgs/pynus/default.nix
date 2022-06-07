{ buildPythonPackage, dbus-python, pygobject3 }:

buildPythonPackage rec {
  pname = "pynus";
  version = "v0.1";
  propagatedBuildInputs = [
    dbus-python
    pygobject3
  ];
  src = ./.;
}

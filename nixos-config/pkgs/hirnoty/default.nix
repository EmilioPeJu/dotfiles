{ buildPythonPackage, fetchgit, pyzmq, aiogram }:

buildPythonPackage rec {
  pname = "hirnoty";
  version = "v0.3";
  doCheck = false;
  propagatedBuildInputs = [ pyzmq aiogram ];
  src = fetchgit {
    url = "https://github.com/lyodaom/hirnoty";
    sha256 = "1p96wq6ycx035s6rfb7sqjl3gyz43yj639xasnd9gyg654b19dls";
  };
}

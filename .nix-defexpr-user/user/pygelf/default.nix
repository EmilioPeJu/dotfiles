{ buildPythonPackage, fetchPypi, pytest, requests, mock }:
buildPythonPackage rec {
  pname = "pygelf";
  version = "0.3.6";
  buildInputs = [ pytest mock ];
  propagatedBuildInputs = [ requests ];
  src = fetchPypi {
    inherit pname version;
    sha256 = "3e5bc59e3b5a754556a76ff2c69fcf2003218ad7b5ff8417482fa1f6a7eba5f9";
  };
}

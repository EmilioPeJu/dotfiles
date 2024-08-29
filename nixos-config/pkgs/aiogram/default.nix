{ buildPythonPackage, fetchPypi, aiohttp, Babel, certifi }:

buildPythonPackage rec {
  pname = "aiogram";
  version = "2.13";
  doCheck = false;
  propagatedBuildInputs = [ aiohttp Babel certifi ];
  src = fetchPypi {
    inherit pname version;
    sha256 = "05miy7dhr3wsk6ndc385k6c0xm1srxcmyr7yz381m3pxh1szampn";
  };
}

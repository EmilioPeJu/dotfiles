{ buildPythonPackage, fetchFromGitHub, setuptools, pygame }:

buildPythonPackage rec {
  pname = "clibt";
  version = "0.0.1";
  src = fetchFromGitHub {
    owner = "EmilioPeJu";
    repo = "clibt";
    rev = "bb6a30e9359dc4d81305f412e0f62de84bdf4ca9";
    sha256 = "sha256-oy8LlgdH73x7vE4Wyk4RZjEHydA2pRxqWWL07c/OxJU=";
  };
  pyproject = true;
  build-system = [ setuptools ];
  propagatedBuildInputs = [ pygame ];
}

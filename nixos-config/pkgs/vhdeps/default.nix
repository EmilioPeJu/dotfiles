{ buildPythonPackage, fetchFromGitHub, plumbum, lcov-cobertura, pip, pylint,
  setuptools-lint, setuptools }:

buildPythonPackage rec {
  pname = "vhdeps";
  version = "0.4.2";
  pyproject = true;
  build-system = [ setuptools ];
  buildInputs = [
    pip
    pylint
    setuptools-lint
  ];
  patchPhase = ''
    sed -i '/better-setuptools-git-version/d' setup.py
    sed -i 's|setup(|setup(version="${version}",|' setup.py
  '';

  propagatedBuildInputs = [ plumbum lcov-cobertura ];
  doCheck = false;
  src = fetchFromGitHub {
    owner = "abs-tudelft";
    repo = pname;
    rev = "${version}";
    hash = "sha256-Ea2hGaQNjf1kVgBMzu/FC31409tLmXAd9zg9kENZPBc=";
  };
}

{ buildPythonPackage, fetchPypi, fetchFromGitHub, bottle, six, requests
, tabulate, pygls, prettytable, typing, argcomplete, waitress }:

buildPythonPackage rec {
  pname = "hdl_checker";
  version = "0.7.4";
  doCheck = false;
  propagatedBuildInputs = [
    bottle
    six
    requests
    tabulate
    pygls
    prettytable
    typing
    argcomplete
    waitress
  ];
  src = fetchPypi {
    inherit pname version;
    sha256 = "0brjpikl2q9jq2qijhfk58940npam4xh3zs850m62mr82qwpl6cg";
  };
  postPatch = ''
            # I know this is so wrong
    	# but the following dependencies are only meant for backward
    	# compatibility and setup.py should be fixed to include them
    	# conditionally
      	sed -i '/typing/d' setup.py
      	sed -i '/argparse/d' setup.py
      	sed -i '/future/d' setup.py
      	sed -i 's/pygls==0.9.1/pygls/g' setup.py
      '';
}

{ buildPythonPackage, fetchPypi, bottle, six, requests, tabulate, pygls
, prettytable, typing, argcomplete, waitress }:

buildPythonPackage rec {
  pname = "hdl_checker";
  version = "0.7.3";
  doCheck = false;
  propagatedBuildInputs =
    [ bottle six requests tabulate pygls prettytable typing argcomplete waitress];
  src = fetchPypi {
    inherit pname version;
    sha256 = "0sg7hjzwcc02f2ibgya3lz5f93ykhdi72c2zxcks301ly1qm9bhi";
  };
  postPatch = ''
        # I know this is so wrong
	# but the following dependencies are only meant for backward
	# compatibility and setup.py should be fixed to include them
	# conditionally
  	sed -i '/typing/d' setup.py
  	sed -i '/argparse/d' setup.py
  	sed -i '/future/d' setup.py
  '';
}

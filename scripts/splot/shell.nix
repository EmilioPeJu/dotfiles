with import <nixpkgs> {};

mkShell {
  buildInputs = [
    python38
    python38Packages.setuptools
    python38Packages.pip
    python38Packages.numpy
    python38Packages.matplotlib
  ];
  shellHook = ''
    alias pip="PIP_PREFIX='$(pwd)/_build/pip_packages' \pip"
    export PYTHONPATH="$(pwd)/_build/pip_packages/lib/python3.8/site-packages:$PYTHONPATH"
    # export PYTHONPATH="$PYTHONPATH:$(pwd)"
    unset SOURCE_DATE_EPOCH
    # pip install -e .
  '';
}

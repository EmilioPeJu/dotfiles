with import <nixpkgs> {};

mkShell {
  buildInputs = [
    dynamips
    python38
    python38Packages.setuptools
    python38Packages.pip
    qt5.full
    (python38Packages.pyqt5.override { withWebSockets = true; })
  ];
  shellHook = ''
    alias pip="PIP_PREFIX='$(pwd)/_build/pip_packages' \pip"
    export PYTHONPATH="$(pwd)/_build/pip_packages/lib/python3.8/site-packages:$PYTHONPATH"
    export PATH="$(pwd)/_build/pip_packages/bin:$PATH"
    # export PYTHONPATH="$PYTHONPATH:$(pwd)"
    unset SOURCE_DATE_EPOCH
    pip install -e $SRCPATH/gns3-server
    pip install -e $SRCPATH/gns3-gui
  '';
}

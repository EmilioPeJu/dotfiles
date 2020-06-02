{ stdenv, perl }:

stdenv.mkDerivation {
  name = "dls-epics";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/epics-base";
    ref = "dls-7.0";
  };

  phases = [ "unpackPhase" "patchPhase" "installPhase" "fixupPhase" ];

  patches = [ ./no_abs_path_to_cc.patch ];

  propagatedBuildInputs = [ perl ];

  setupHook = builtins.toFile "setupHook.sh" ''
    export EPICS_BASE='@out@'
  '';

  configurePhase = "# nothing to do";
  buildPhase = ''
    # Dummy build phase, as it is done as part of installPhase
  '';

  installPhase = ''
    make INSTALL_LOCATION=$out
    cd $out/bin
    for i in linux-x86_64/*; do
        ln -s "$i"
    done
  '';

  meta = {
    priority = 3;
  };
}

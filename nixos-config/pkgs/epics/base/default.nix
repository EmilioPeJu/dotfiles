{ fetchgit, stdenv, perl, readline, lib, config }:

stdenv.mkDerivation {
  name = "epics-base";
  src = fetchgit {
    url = "https://github.com/epics-base/epics-base.git";
    rev = "R7.0.8.1";
    hash = "sha256-JDSMBwBLZj9aaxJHGg0QmZ1zYTSY8J7+ZGihAwEuz3w=";
    fetchSubmodules = true;
  };

  phases = [ "unpackPhase" "patchPhase" "installPhase" "fixupPhase" ];

  patches = [ ./no_abs_path_to_cc.patch ];

  buildInputs = [ readline ];
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

  meta.priority = 4;
}

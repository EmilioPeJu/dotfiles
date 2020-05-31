{ stdenv, coreutils, readline, perl }:

stdenv.mkDerivation rec {
  name = "dls-epics";
  version = "7.0";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/epics-base";
    ref = "dls-7.0";
  };

  phases = [ "unpackPhase" "patchPhase" "buildPhase" "installPhase" "fixupPhase" ];

  patches = [ ./no_abs_path_to_cc.patch ];

  buildInputs = [ perl ];

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
}

{ cmake, hdf5, c-blosc, stdenv }:

stdenv.mkDerivation {
  name = "hdf5_filters";
  buildInputs = [ cmake hdf5 c-blosc ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/hdf5_filters";
    ref = "master";
  };

  configurePhase = ''
    runHook preConfigure
    cmake -DCMAKE_INSTALL_PREFIX=$out/hdf5_1.10 -DCMAKE_BUILD_TYPE=Release .
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  findSrc = builtins.toFile "find-epics" ''
    #!/usr/bin/env bash
    echo @out@
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    substituteAll $findSrc $out/bin/find-dls-epics-hdf5_filters
    chmod +x $out/bin/find-dls-epics-hdf5_filters
    make install
    runHook postInstall
  '';
}

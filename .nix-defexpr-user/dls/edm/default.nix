{ libpng, zlib, freetype, fontconfig, patch-configure, giflib, motif, xorg
, readline, dls-epics-base, stdenv }:

stdenv.mkDerivation {
  name = "edm";
  buildInputs = [
    libpng
    zlib.dev
    patch-configure
    giflib
    xorg.libX11
    xorg.libXt
    xorg.libXpm
    xorg.libXext
    xorg.libXmu
    xorg.libXp
    xorg.libXt
    xorg.libXtst
    freetype
    fontconfig
    motif
    readline
    dls-epics-base
  ];
  patches = [ ./libs-to-syslibs.patch ];
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/edm";
    ref = "master";
  };

  findSrc = builtins.toFile "find-epics" ''
    #!/usr/bin/env bash
    echo @out@
  '';

  configurePhase = ''
    runHook preConfigure
    patch-configure configure/RELEASE
    cat << EOF > configure/os/CONFIG_SITE.linux-x86_64.linux-x86_64
    -include \$(TOP)/configure/os/CONFIG_SITE.linux-x86.linux-x86
    X11_LIB=${xorg.libX11}/lib
    X11_INC=${xorg.libX11}/include
    MOTIF_LIB=${motif}/lib
    MOTIF_INC=${motif}/include
    EOF
  '';

  buildPhase = ''
    true
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp -rf * $out
    substituteAll $findSrc $out/bin/find-$name
    chmod +x $out/bin/find-$name
    cd $out
    export EPICS_EXTENSIONS=$out
    make
    ln -s $out/bin/linux-x86_64/edm $out/bin
    find . \( -name '*.c' -or -name '*.cc' -or -name '*.cpp' -or -name '*.o' \) -exec rm {} \;
    runHook postInstall
  '';
}

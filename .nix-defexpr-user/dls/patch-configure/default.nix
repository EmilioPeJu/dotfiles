{ python3, stdenv }:

stdenv.mkDerivation {
  name = "patch-configure";
  phases = [ "installPhase" "fixupPhase" ];
  buildInputs = [ python3 ];
  src = ./patch-configure;
  configurePhase = "# nothing to do";
  buildPhase = "# nothing to do";
  fixupPahse = "patchShebangs $out/bin/patch-configure";
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/patch-configure
    chmod +x $out/bin/patch-configure
  '';
}

{ stdenv, fetchgit, pkg-config, meson, ninja }:

stdenv.mkDerivation rec {
  name = "libunity";
  version = "2.5.1";
  src = fetchgit {
    url = "https://github.com/ThrowTheSwitch/Unity";
    rev = "v${version}";
    sha256 = "068wfsnbmli9hxg94j8928niy6lia12918i1k3nfgc967m7bcj9a";
  };
  buildInputs = [ pkg-config meson ninja ];
  phases = [ "unpackPhase" "buildPhase" "installPhase" ];
  buildPhase = ''
    meson _build
    meson compile -C _build
  '';
  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/lib/pkgconfig
    mkdir -p $out/include
    cp _build/meson-out/libunity.a $out/lib
    cp src/*.h $out/include
    cat <<EOF > $out/lib/pkgconfig/libunity.pc
    Name: libunity
    Description: Unit test framework
    Version: ${version}
    CFlags: -I$out/include
    Libs: -L$out/lib -lunity
    EOF
  '';
}

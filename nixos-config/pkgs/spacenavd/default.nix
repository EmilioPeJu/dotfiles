{fetchgit, stdenv, xorg}:

stdenv.mkDerivation rec {
  name = "spacenavd";
  version = "0.7.1";
  src = fetchgit {
    url = "https://github.com/FreeSpacenav/spacenavd";
    rev = "v${version}";
    sha256 = "1k7jrm0xp6zmf7j72nnbqb54vs7qj08arx4xa0v99ra2369q88ii";
  };
  buildInputs = [ xorg.libX11 ];
  postInstall = ''
    mkdir -p $out/lib/systemd/system
    sed 's|/usr|'$out'|' contrib/systemd/spacenavd.service \
        > $out/lib/systemd/system/spacenavd.service
  '';
}

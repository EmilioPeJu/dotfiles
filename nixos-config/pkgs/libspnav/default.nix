{fetchgit, stdenv, xorg}:

stdenv.mkDerivation rec {
  name = "libspnav";
  version = "0.2.3";
  src = fetchgit {
    url = "https://github.com/FreeSpacenav/libspnav.git";
    rev ="v${version}";
    sha256 = "15i615i4mr3fxr8x05zpbvcx5sqr6ksircz7v66bkvkvjj7y059x";
  };
  buildInputs = [ xorg.libX11 ];
}

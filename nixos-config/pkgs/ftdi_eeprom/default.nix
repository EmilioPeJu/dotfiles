{ cmake, fetchgit, libconfuse, libftdi, pkg-config, stdenv }:

stdenv.mkDerivation rec {
  name = "ftdi_eeprom";
  src = fetchgit {
    url = "git://developer.intra2net.com/ftdi_eeprom";
    rev = "07d3572091f993e2844b82818285e7ce6d6e9de2";
    sha256 = "1qzi8skg0ggld7gkply2ac92rrd5jzx77rap45wg387my8azc7w0";
  };
  buildInputs = [ cmake libconfuse libftdi pkg-config ];
}

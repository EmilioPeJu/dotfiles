{ fetchurl, stdenv }:

stdenv.mkDerivation rec {
  name = "noip2";
  version = "2.1.9";
  src = fetchurl {
    url = "https://www.noip.com/client/linux/noip-duc-linux.tar.gz";
    sha256 = "82b9bafab96a0c53b21aaef688bf70b3572e26217b5e2072bdb09da3c4a6f593";
  };
  buildPhase = "make";
  installPhase = ''
    mkdir -p "$out/bin"
    cp noip2 "$out/bin"
  '';
}

{ stdenv, fetchFromGitHub, autoconf, automake, gnumake, openssl, procps, which
}:

stdenv.mkDerivation rec {
  name = "nagios-plugins";
  version = "2.4.0";
  src = fetchFromGitHub {
    owner = "nagios-plugins";
    repo = name;
    rev = "release-${version}";
    sha256 = "g1f/0vQ6F089Hw1GXgtP4eRw9o3fk+8veiAzog/Ouuk=";
  };
  buildInputs = [ autoconf automake gnumake openssl procps which ];
  configurePhase = "./autogen.sh --prefix $out";
  installPhase = ''
    make install
    make install-packager
    mkdir $out/bin
    cp -s $out/libexec/check* $out/bin/
  '';
}

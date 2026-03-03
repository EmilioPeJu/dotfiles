{ stdenv, linuxPackages, autoconf, automake, pkg-config, libtool }:

stdenv.mkDerivation rec {
  name = "etherlab";
  nativeBuildInputs = [ autoconf automake libtool pkg-config ];
  src = builtins.fetchGit {
    url = "https://gitlab.com/etherlab.org/ethercat.git";
    ref = "stable-1.6";
  };
  outputs = [ "out" "dev" ];
  patches = [ ./sockaddr_unsized.patch ];
  KERNELDIR =
    "${linuxPackages.kernel.dev}/lib/modules/${linuxPackages.kernel.modDirVersion}/build";
  preConfigure = ''
    touch ChangeLog
    autoreconf -i
  '';
  configureFlags = [
    "--with-linux-dir=${KERNELDIR}"
    "--prefix=$(out)"
    "--disable-8139too"
    "--disable-r8169"
    "--enable-generic"
  ];
  buildPhase = ''
    runHook preBuild
    make all modules
    runHook postBuild
  '';
  installPhase = ''
    runHook preInstall
    make install
    make modules_install INSTALL_MOD_PATH=$out
    runHook postInstall
    mkdir $dev/lib
    cp -rf lib/*.h $dev/lib
    mkdir $dev/master
    cp -rf master/*.h $dev/master
    cp -f *.h $dev
  '';
}

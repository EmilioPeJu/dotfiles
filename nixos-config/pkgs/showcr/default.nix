{ stdenv, linuxPackages }:

stdenv.mkDerivation rec {
  name = "showcr";
  src = ./.;
  KERNELDIR =
    "${linuxPackages.kernel.dev}/lib/modules/${linuxPackages.kernel.modDirVersion}/build";
  buildInputs = [ linuxPackages.kernel.dev ];
  buildPhase = ''
    runHook preBuild
    make -C ${KERNELDIR} M=$(pwd) modules
    runHook postBuild
  '';
  installPhase = ''
    mkdir -p $out
    runHook preInstall
    make -C ${KERNELDIR} M=$(pwd) modules_install INSTALL_MOD_PATH=$out
    runHook postInstall
  '';
}

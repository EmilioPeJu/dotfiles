self: super:

{
  dwm = super.stdenv.mkDerivation rec {
    name="dwm";
    buildInputs=[
      super.xorg.libX11
      super.xorg.libXft
      super.xorg.libXinerama
    ];
    configFile=~/dwm/config.h;
    src=~/dwm/src;
    postPatch=''
      cp -f ${configFile} config.h
    '';
    installPhase = ''
      make install PREFIX=$out
    '';
  };
}

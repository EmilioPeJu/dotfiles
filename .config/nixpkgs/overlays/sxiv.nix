self: super:

{
  sxiv = super.stdenv.mkDerivation rec {
    name="sxiv";
    buildInputs=[
      super.fontconfig
      super.imlib2
      super.freetype
      super.giflib
      super.libexif
      super.xorg.libX11
      super.xorg.libXft
    ];
    configFile=~/suckless/sxiv/config.h;
    src=~/suckless/sxiv/src;
    postPatch=''
      cp -f ${configFile} config.h
    '';
    installPhase = ''
      make install PREFIX=$out
    '';
  };
}

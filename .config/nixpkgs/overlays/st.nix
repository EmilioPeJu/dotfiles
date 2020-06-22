self: super:

{
  st = super.stdenv.mkDerivation rec {
    name="st";
    buildInputs=[
      super.xorg.libX11
      super.xorg.libXft
      super.xorg.libXinerama
      super.freetype
      super.pkgconfig
      super.ncurses
      super.fontconfig
    ];
    configFile=~/st/config.h;
    src=~/st/src;
    postPatch=''
      cp -f ${configFile} config.h
    '';
    installPhase = ''
      TERMINFO=$out/share/terminfo make install PREFIX=$out
    '';
  };
}

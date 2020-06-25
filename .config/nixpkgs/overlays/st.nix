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
    configFile=~/suckless/st/config.h;
    src=~/suckless/st/src;
    patches = [ ~/suckless/st/st-alpha-0.8.2.diff ];
    postPatch=''
      cp -f ${configFile} config.h
    '';
    installPhase = ''
      TERMINFO=$out/share/terminfo make install PREFIX=$out
    '';
  };
}

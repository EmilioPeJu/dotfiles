self: super:

{
  slock = super.stdenv.mkDerivation rec {
    name = "slock";
    buildInputs = [
      super.xorg.libX11
      super.xorg.libXext
      super.xorg.libXrandr
      super.xorg.xorgproto
    ];
    configFile = ~/suckless/slock/config.h;
    src = ~/suckless/slock/src;
    postPatch = ''
      sed -i '/chmod u+s/d' Makefile
      cp -f ${configFile} config.h
    '';
    installPhase = ''
      make install PREFIX=$out
    '';
  };
}

self: super:

{
  dwm = super.stdenv.mkDerivation rec {
    name = "dwm";
    buildInputs =
      [ super.xorg.libX11 super.xorg.libXft super.xorg.libXinerama ];
    patches = [ ~/suckless/dwm/dwm-scratchpad-6.2.diff ];
    configFile = ~/suckless/dwm/config.h;
    src = ~/suckless/dwm/src;
    postPatch = ''
      cp -f ${configFile} config.h
    '';
    installPhase = ''
      make install PREFIX=$out
    '';
  };
}

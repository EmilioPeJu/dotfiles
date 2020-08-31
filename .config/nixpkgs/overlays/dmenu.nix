self: super:

{
  dmenu = super.stdenv.mkDerivation rec {
    name = "dmenu";
    src = ~/suckless/dmenu/src;
    configFile = ~/suckless/dmenu/config.h;
    buildInputs =
      [ super.xorg.libX11 super.xorg.libXinerama super.xorg.libXft super.zlib ];
    patches = [ ];
    postPatch = ''
      sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
      sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
      cp ${configFile} config.h
    '';
    preConfigure = ''
      sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
    '';
    makeFlags = [ "CC:=$(CC)" ];
  };
}

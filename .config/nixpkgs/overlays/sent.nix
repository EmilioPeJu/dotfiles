self: super:

{
  sent = super.stdenv.mkDerivation rec {
    name = "sent";
    src = ~/suckless/sent/src;
    configFile = ~/suckless/sent/config.h;
    buildInputs = [ super.xorg.libX11 super.xorg.libXft ];
    nativeBuildInputs = [ super.makeWrapper ];
    patches = [ ];
    postPatch = ''
      cp ${configFile} config.h
    '';
    installFlags = [ "PREFIX=$(out)" ];
    postInstall = ''
      wrapProgram "$out/bin/sent" --prefix PATH : "${super.farbfeld}/bin"
    '';
  };
}

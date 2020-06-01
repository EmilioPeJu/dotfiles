{ stdenv, gcc, dls-epics, patch-configure}:
{ buildInputs ? [], ...} @args:
let newargs =
  args // {
    buildInputs = [ dls-epics patch-configure ] ++ buildInputs;

    configurePhase = ''
      patch-configure -i configure/RELEASE
      [ -f etc/Makefile ] && {
        sed -i /makeIocs/d etc/Makefile;
        sed -i /makeDocumentation/d etc/Makefile
      }
    '';

    buildPhase = "# Dummy, it is done as part of installPhase";

    installPhase = ''
      make INSTALL_LOCATION=$out
    '';
  };
in
stdenv.mkDerivation newargs

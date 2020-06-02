{ stdenv, dls-epics, patch-configure}:
{ buildInputs ? [], ...} @args:
let newargs =
  args // {
    buildInputs = [ dls-epics patch-configure ] ++ buildInputs;

    configurePhase = ''
      runHook preConfigure
      # patch release files to point to dependencies
      for path in "configure/RELEASE" "configure/RELEASE.linux-x86_64.Common" "configure/RELEASE.local"; do
        if [ -f "$path" ]; then
          patch-configure -i "$path"
         fi
      done
      # don't make examples or docs
      if [ -f etc/Makefile ]; then
        sed -i /makeIocs/d etc/Makefile;
        sed -i /makeDocumentation/d etc/Makefile;
      fi
      runHook postConfigure
    '';

    buildPhase = "# Dummy, it is done as part of installPhase";

    installPhase = ''
      runHook preInstall
      make INSTALL_LOCATION=$out
      runHook postInstall
    '';
  };
in
stdenv.mkDerivation newargs

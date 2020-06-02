{ libxml2, buildEpicsModule, dls-epics-asyn, dls-epics-busy, dls-epics-sscan, dls-epics-calc, dls-epics-adsupport, dls-epics-pvdata, dls-epics-normativetypes, dls-epics-pvaccess, dls-epics-pvdatabase }:

buildEpicsModule rec {
  name = "dls-epics-adcore";
  buildInputs = [ libxml2.dev dls-epics-asyn dls-epics-busy dls-epics-sscan dls-epics-calc dls-epics-adsupport dls-epics-pvdata dls-epics-normativetypes dls-epics-pvaccess dls-epics-pvdatabase ];
  preConfigure = ''
    # temporal fix to non standard variable names in release file
    sed -i 's/CPP//g' configure/RELEASE.local
    sed -i '/HDF5_FILTER/d' configure/RELEASE.local
    cat << EOF > configure/CONFIG_SITE.linux-x86_64.Common
    JPEG_EXTERNAL = NO
    WITH_TIFF     = YES
    TIFF_EXTERNAL = NO
    WITH_XML2     = YES
    XML2_EXTERNAL = YES
    XML2_INCLUDE = ${libxml2.dev}/include/libxml2
    WITH_ZLIB     = YES
    ZLIB_EXTERNAL = NO
    # Enable PVA plugin
    WITH_PVA = YES
    WITH_BLOSC    = YES
    BLOSC_EXTERNAL= NO
    EOF
  '';
  postInstall = ''
    mkdir -p $out/ADApp
    cp ADApp/common*Makefile $out/ADApp
  '';
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/adcore";
    ref = "dls-master";
  };
}

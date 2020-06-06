{ buildEpicsModule }:

buildEpicsModule {
  name = "dls-epics-adsupport";
  src = builtins.fetchGit {
    url = "https://github.com/hir12111/adsupport";
    ref = "dls-master";
  };
  preConfigure = ''
    cat << EOF >  configure/CONFIG_SITE.linux-x86_64.Common
    CROSS_COMPILER_TARGET_ARCHS =
    WITH_HDF5     = YES
    HDF5_EXTERNAL = NO
    WITH_SZIP     = YES
    SZIP_EXTERNAL = NO
    WITH_JPEG     = YES
    JPEG_EXTERNAL = NO
    WITH_TIFF     = YES
    TIFF_EXTERNAL = NO
    WITH_XML2 = YES
    XML2_EXTERNO = NO
    WITH_ZLIB     = YES
    ZLIB_EXTERNAL = NO
    WITH_BLOSC    = YES
    BLOSC_EXTERNAL = NO
    WITH_CBF      = NO
    CBF_EXTERNAL  = NO
    EOF
  '';
}

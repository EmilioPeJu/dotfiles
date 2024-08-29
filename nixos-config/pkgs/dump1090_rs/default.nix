{ lib, stdenv, makeWrapper, fetchFromGitHub, rustPlatform, llvm, clang
, pkg-config, libclang, soapysdr, soapyhackrf, soapyrtlsdr }:

rustPlatform.buildRustPackage rec {
  pname = "dump1090_rs";
  version = "v0.6.1";
  src = fetchFromGitHub {
    owner = "rsadsb";
    repo = pname;
    rev = version;
    hash = "sha256-0aeuyISg1qBz+PwmliRgcW0JJGMGDHQ6Q71+kEITOq4=";
  };
  cargoHash = "sha256-736SXYf4KCXrrLroJsGqvmWpWQbTetC4vv/yyapEg8o=";
  LIBCLANG_PATH = "${libclang.lib}/lib";
  nativeBuildInputs = [ pkg-config rustPlatform.bindgenHook makeWrapper ];
  buildInputs =
    [ clang soapysdr soapyhackrf soapyrtlsdr stdenv libclang.lib libclang.dev ];
  postFixup = ''
    wrapProgram "$out/bin/dump1090_rs" \
      --set SOAPY_SDR_PLUGIN_PATH \
      "${soapyrtlsdr}/lib/SoapySDR/modules0.8/:${soapyhackrf}/lib/SoapySDR/modules0.8/"
  '';
}

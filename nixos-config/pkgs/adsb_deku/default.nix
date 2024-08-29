{ lib, stdenv , fetchFromGitHub , rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "adsb_deku";
  version = "v2022.12.29";
  src = fetchFromGitHub {
    owner = "rsadsb";
    repo = pname;
    rev = version;
    hash = "sha256-Ur5syCGK3bbCOj6h09Txe6uciE0eF768Xryx4J83NwQ=";
  };
  cargoHash = "sha256-AoLznQ7mnskspwLz0bWWN921iBa7CTuvrTHhp23o/Fs=";
  buildInputs = [];
}

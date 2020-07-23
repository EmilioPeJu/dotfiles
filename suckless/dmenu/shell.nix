with import <nixpkgs> {};

mkShell {
  buildInputs = [
    gnumake
    gcc
    xorg.libX11
    xorg.libXinerama
    xorg.libXft
    zlib
  ];
}

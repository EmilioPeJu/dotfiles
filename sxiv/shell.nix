with import <nixpkgs> {};

mkShell {
  buildInputs = [
    fontconfig
    imlib2
    freetype
    giflib
    gnumake
    gcc
    libexif
    xorg.libX11
    xorg.libXft
  ];
}

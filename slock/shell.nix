with import <nixpkgs> {};

mkShell {
  buildInputs = [
    gnumake
    gcc
    xorg.libX11
    xorg.libXrandr
    xorg.libXext
  ];
}

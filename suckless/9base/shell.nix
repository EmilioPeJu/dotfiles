with import <nixpkgs> {};

mkShell {
  buildInputs = [
    gcc
    gnumake
    musl
  ];
}

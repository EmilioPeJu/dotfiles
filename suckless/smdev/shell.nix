with import <nixpkgs> {};

mkShell {
  buildInputs = [
    gnumake
    gcc
  ];
}

{pkgs ? import <nixpkgs> {}}:

with pkgs;
let fhs = buildFHSUserEnv rec {
  name = "buildroot-shell";
  targetPkgs = pkgs: with pkgs; [
    gcc
    binutils
    gnumake
    which
    perl
    git
    glibc
    ncurses
    pkgconfig
    file
    bc
  ];
  extraOutputsToInstall = ["dev"];
  profile = ''
  '';
};
in fhs.env

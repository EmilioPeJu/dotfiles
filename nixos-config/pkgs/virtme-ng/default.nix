{ buildPythonPackage, fetchFromGitHub, cargo, rustc, setuptools,
  argcomplete, argparse-manpage, requests, qemu_full, virtiofsd }:

buildPythonPackage rec {
  pname = "virtme-ng";
  version = "v1.37";
  pyproject = true;
  build-system = [ setuptools ];
  propagatedBuildInputs = [
    argcomplete
    argparse-manpage
    requests
    qemu_full
    virtiofsd
  ];
  src = /scratch/src/virtme-ng;
  # src = fetchFromGitHub {
  #   owner = "arighi";
  #   repo = pname;
  #   rev = "${version}";
  #   hash = "sha256-zP0017295qDE/DAS/swSr4VY8IikRhfUbZbY4N/KeJw=";
  # };
}

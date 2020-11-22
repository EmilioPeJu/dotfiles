{stdenv, git, libusb, pkg-config, which}:

stdenv.mkDerivation rec {
  name = "minipro";
  src = builtins.fetchGit {
    url = "https://gitlab.com/DavidGriffith/minipro.git";
    ref = "refs/tags/0.5";
  };
  patches = [ ./default_udev_dir.patch ];
  makeFlags = [
    "PREFIX=$(out)"
    "UDEV_DIR=$(out)/lib/udev"
  ];
  buildInputs = [ git libusb pkg-config which ];
}

{ config, pkgs, ... }:

let 
  spacenavd = pkgs.callPackage ./pkgs/spacenavd {};
  libspnav = pkgs.callPackage ./pkgs/libspnav {};
in
{
  environment.systemPackages = with pkgs; [
    # freecad with 3D mouse support
    (freecad.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [libspnav];
    }))
    # openscad with 3D mouse support
    (openscad.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [ libspnav ];
      postPatch = ''
        sed -i '$ a SPNAV_INCLUDEPATH = '"${libspnav}/include" openscad.pro
        sed -i '$ a SPNAV_LIBPATH = '"${libspnav}/lib" openscad.pro
      '';
    }))
    spacenavd
  ];
  systemd.services.spacenavd.enable = true;
  security.wrappers.spacenavd.source = "${spacenavd}/bin/spacenavd";
}

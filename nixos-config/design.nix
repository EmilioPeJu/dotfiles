{ config, pkgs, ... }:

let 
  spacenavd = pkgs.callPackage ./pkgs/spacenavd {};
  libspnav = pkgs.callPackage ./pkgs/libspnav {};
in
{
  environment.systemPackages = with pkgs; [
    (freecad.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs ++ [libspnav];
    }))
    spacenavd
  ];
  systemd.services.spacenavd.enable = true;
  security.wrappers.spacenavd.source = "${spacenavd}/bin/spacenavd";
}

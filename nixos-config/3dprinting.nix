{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    freecad
    klipper
    octoprint
    openscad
    orca-slicer
    printrun
  ];
}

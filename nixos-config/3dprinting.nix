{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    klipper
    octoprint
    openscad
    orca-slicer
    printrun
  ];
}

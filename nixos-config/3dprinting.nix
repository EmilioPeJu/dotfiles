{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    klipper
    octoprint
    openscad
    orca-slicer
    printrun
  ];
}

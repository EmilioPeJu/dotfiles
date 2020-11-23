{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    blender
    printrun
    slic3r
  ];
}

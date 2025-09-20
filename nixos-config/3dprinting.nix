{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    klipper
    openscad
    printrun
    #slic3r
  ];
}

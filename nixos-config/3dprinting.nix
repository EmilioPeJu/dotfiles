{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    printrun
    slic3r
  ];
}

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ openscad printrun slic3r ];
}

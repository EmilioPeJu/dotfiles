{ config, pkgs, ... }:

let 
  minipro = pkgs.callPackage ./pkgs/minipro {};
in
{
  environment.systemPackages = with pkgs; [
    arduino
    flashrom
    minipro
  ];
  services.udev.packages = [ minipro ];
}

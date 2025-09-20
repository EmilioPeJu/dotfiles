{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    audacity
    gmetronome
    lingot
    #lmms
    mixxx
    #supercollider-with-plugins
    #tuxguitar
  ];
}

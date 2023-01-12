{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Music edition
    audacity
    tuxguitar
    fluidsynth
    jack2
    klick
    lmms
    musescore
    pianobooster
    solfege
    soundfont-fluid
    sox
  ];
}

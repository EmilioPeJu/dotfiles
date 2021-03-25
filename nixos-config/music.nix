{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Music edition
    audacity
    fluidsynth
    lmms
    musescore
    pianobooster
    solfege
    soundfont-fluid
    sox
  ];
}

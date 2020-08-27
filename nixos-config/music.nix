{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Music edition
    audacity
    lmms
    musescore
    pianobooster
    solfege
    soundfont-fluid
    sox
  ];
}

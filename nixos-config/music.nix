{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Music edition
    audacity
    tuxguitar
    lmms
  ];
}

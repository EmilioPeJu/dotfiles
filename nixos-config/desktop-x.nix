{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  environment.systemPackages = with pkgs; [
    dmenu
    dunst
    dwm
    i3status
    maim
    slock
    xcompmgr
    xorg.xhost
    xorg.xinit
    xorg.xkill
  ];
}

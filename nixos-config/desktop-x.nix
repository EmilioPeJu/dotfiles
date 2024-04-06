{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    wacom.enable = true;
  };

  programs.slock.enable = true;

  environment.systemPackages = with pkgs; [
    autocutsel
    bspwm
    conky
    dmenu
    dunst
    dwm
    eww
    maim
    polybar
    rofi
    sxhkd
    tdrop
    xcompmgr
    xorg.xhost
    xorg.xkill
  ];
}

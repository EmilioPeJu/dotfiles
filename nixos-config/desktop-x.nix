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
    conky
    dmenu
    dunst
    dwm
    eww
    maim
    rofi
    xcompmgr
    xorg.xhost
    xorg.xkill
  ];
}

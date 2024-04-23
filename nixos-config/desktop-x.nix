{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    wacom.enable = true;
    xkb = {
      layout = "us";
      variant = "altgr-intl";
      options = "ctrl:nocaps";
    };
  };

  programs.slock.enable = true;

  environment.systemPackages = with pkgs; [
    autocutsel
    bspwm
    conky
    dmenu
    dunst
    eww
    maim
    picom
    polybar
    rofi
    sxhkd
    tdrop
    xcompmgr
    xorg.xhost
    xorg.xkill
  ];
}

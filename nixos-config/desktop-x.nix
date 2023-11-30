{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
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
    xcompmgr
    xorg.xhost
    xorg.xkill
  ];
}

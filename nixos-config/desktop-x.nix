{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

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

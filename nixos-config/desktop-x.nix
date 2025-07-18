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
    i3lock
    libvibrant
    maim
    picom
    polybar
    rofi
    sxhkd
    tdrop
    xcompmgr
    xorg.xgamma
    xorg.xhost
    xorg.xkill
    # Keyboard
    xorg.setxkbmap
    xorg.xev
    xorg.xkbcomp
    xorg.xmodmap
  ];
}

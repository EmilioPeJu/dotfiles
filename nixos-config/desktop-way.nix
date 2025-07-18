{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  #Programs
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    cliphist
    dmenu-wayland
    eww
    grim
    hypridle
    hyprpaper
    kitty
    mako
    nwg-bar
    rofi
    slurp
    swayidle
    swaylock
    wl-clipboard
    swww
    waybar
  ];
}

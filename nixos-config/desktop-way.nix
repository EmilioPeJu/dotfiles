{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  #Programs
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    clipman
    dmenu-wayland
    eww-wayland
    grim
    kitty
    mako
    nwg-bar
    slurp
    swayidle
    swaylock
    wl-clipboard
    wofi
    swww
    waybar
  ];
}

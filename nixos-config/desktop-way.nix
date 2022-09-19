{ config, lib, pkgs, ... }:

{
  imports = [ ./desktop.nix ];

  #Programs
  programs.sway.enable = true;

  environment.systemPackages = with pkgs; [
    clipman
    dmenu-wayland
    grim
    mako
    slurp
    waybar
    wl-clipboard
  ];
}

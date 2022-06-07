{ config, pkgs, ... }:

{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    abootimg
    android-studio
    apktool
    jdk11
  ];
  services.udev.packages = [ pkgs.android-udev-rules ];
  users.users.user.extraGroups = [ "adbusers" ];
}

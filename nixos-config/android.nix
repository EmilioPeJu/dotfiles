{ config, pkgs, ... }:

{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    abootimg
    #android-studio
    apktool
    kotlin
  ];
  services.udev.packages = [ pkgs.android-udev-rules ];
  users.users.user.extraGroups = [ "adbusers" ];
}

{ config, pkgs, ... }:

{
  programs.adb.enable = true;
  environment.systemPackages = with pkgs; [
    abootimg
    adb-sync
    #android-studio
    android-tools
    apktool
    #kotlin
  ];
  services.udev.packages = [ pkgs.android-udev-rules ];
  users.users.user.extraGroups = [ "adbusers" ];
}

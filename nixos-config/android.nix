{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    abootimg
    adb-sync
    #android-studio
    android-tools
    apktool
    #kotlin
  ];
  users.users.user.extraGroups = [ "adbusers" ];
}

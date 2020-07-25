{ config, pkgs, ... }:

{
  # Security
  security.sudo.enable = true;
  security.sudo.configFile = ''
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/mount
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/umount
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/nmtui-connect
  '';
  security.audit = {
    backlogLimit = 8192;
    enable = true;
    failureMode = "printk";
  };
  #security.auditd.enable = true;

}

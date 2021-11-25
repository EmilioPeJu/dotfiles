{ config, pkgs, ... }:

{
  # Security
  security.sudo.enable = true;
  security.sudo.configFile = ''
    user ALL=(ALL) NOPASSWD:/run/wrappers/bin/mount
    user ALL=(ALL) NOPASSWD:/run/wrappers/bin/umount
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/nmtui-connect
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/nixos-rebuild switch
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/systemctl suspend
  '';
  security.audit = {
    backlogLimit = 8192;
    enable = true;
    failureMode = "printk";
  };
  #security.auditd.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
    });
  '';
}

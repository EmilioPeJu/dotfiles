{ config, pkgs, ... }:

{
  # Security
  security.sudo.enable = true;
  security.sudo.configFile = ''
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/systemctl suspend
    user ALL=(ALL) NOPASSWD:/run/wrappers/bin/mount -t nfs -o rw\,soft server1\:/rpool/user /ext/server
    user ALL=(ALL) NOPASSWD:/run/wrappers/bin/umount /ext/server
    user ALL=(ALL) NOPASSWD:/run/wrappers/bin/mount -t nfs -o rw\,soft arm1\:/mnt /ext/media
    user ALL=(ALL) NOPASSWD:/run/wrappers/bin/umount /ext/media
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

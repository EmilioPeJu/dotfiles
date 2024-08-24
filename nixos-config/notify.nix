{ config, pkgs, ... }:

let dirty = (import ./dirty.nix { });
in {
  systemd.timers.sched-timer1 = {
    wantedBy = [ "timers.target" ];
    partOf = [ "sched-timer.service" ];
    timerConfig.OnCalendar = "*-*-* 08:30:00";
  };
  systemd.services.sched-timer1 = {
    serviceConfig.Type = "oneshot";
    serviceConfig.User = "user";
    script = ''
      export PATH=/run/current-system/sw/bin
      export USER=user
      export HOME=/home/user
      rems="$(remind /home/user/remind/top.rem '*1')"
      ${pkgs.curl}/bin/curl -H "Priority: urgent" -d "$rems" ${dirty.ntfyUrl}
      selected=$(sort -R /home/user/remind/lists/study.md | sed '/^#/d' | head -n1)
      ${pkgs.curl}/bin/curl -H "Priority: urgent" -d "$selected" ${dirty.ntfyUrl}
    '';
  };
}

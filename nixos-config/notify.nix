{ config, pkgs, ... }:

let
  aiogram = (pkgs.python3Packages.callPackage ./pkgs/aiogram { });
  hirnoty =
    (pkgs.python3Packages.callPackage ./pkgs/hirnoty { aiogram = aiogram; });
  dirty = (import ./dirty.nix { });
in {
  environment.etc."hirnoty/config.py".source = pkgs.writeText "config" ''
    TOKEN = "${dirty.botToken}";
    ACL = [ ${dirty.userID} ]
    SCRIPT_DIR = "/home/user/.config/hirnoty/scripts"
    INDEX_DIR = "/home/user/.config/hirnoty/index"
  '';
  systemd.timers.sched-timer = {
    wantedBy = [ "timers.target" ];
    partOf = [ "sched-timer.service" ];
    timerConfig.OnCalendar = "*-*-* 08:30:00";
  };
  systemd.services.sched-timer = {
    serviceConfig.Type = "oneshot";
    serviceConfig.User = "user";
    script = ''
      export PATH=/run/current-system/sw/bin
      export USER=user
      export HOME=/home/user
      remind /mnt/proc/remind/top.rem '*3' | hirnoty-send -t sched
    '';
  };
  systemd.services."hirnoty" = {
    enable = true;
    unitConfig = {
      Requires = "network-online.target";
      After = "network-online.target";
    };
    serviceConfig = {
      Type = "simple";
      ExecStart = "${hirnoty}/bin/hirnoty-ctl start";
      User = "user";
    };
    wantedBy = [ "multi-user.target" ];
  };
  environment.systemPackages = with pkgs; [ hirnoty ];
}

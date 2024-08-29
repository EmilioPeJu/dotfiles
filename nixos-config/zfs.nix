{ config, pkgs, ... }:

{
  # requires to set networking.HostId
  boot.supportedFilesystems = [ "zfs" ];
  # workaround to import zpools at boot time
  # ( I don't want to use mountpoint=legacy )
  systemd.services."custom-zfs-import-cache" = {
    enable = true;
    unitConfig = {
      DefaultDependencies = "no";
      Requires = "systemd-udev-settle.service";
      After = "systemd-udev-settle.service";
      Before = "zfs-import.target";
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.zfs}/bin/zpool import -aN";
    };
    wantedBy = [ "zfs-import.target" ];
  };
}

{ config, lib, pkgs, ... }:

{
  services.yggdrasil = {
    enable = true;
    configFile = "/home/user/.config/yggdrasil/yggdrasil.conf";
  };
  # don't start daemon at boot time
  systemd.services.yggdrasil.wantedBy = lib.mkForce [ ];
}

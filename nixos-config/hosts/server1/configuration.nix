# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  # workaround for enabling wake-on-lan
  wolScript = pkgs.writeScript "wolScript" ''
    #!${pkgs.stdenv.shell}
    ${pkgs.ethtool}/bin/ethtool -s enp2s0 wol g
    ${pkgs.ethtool}/bin/ethtool -s enp3s0 wol g
  '';
in {
  imports = [
    ./hardware-configuration.nix
    ../../base.nix
    ../../overrides.nix
    ../../security-options.nix
    ../../ssh.nix
    ../../user.nix
  ];

  boot.supportedFilesystems = [ "zfs" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "server1";
    hostId = "16ab23fb";
    extraHosts = builtins.readFile ../../extra_hosts;
    firewall.allowedTCPPorts = [ 111 2049 4045 20048 ];
    firewall.allowedUDPPorts = [ 111 2049 4045 20048 ];
  };

  # NFS server
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /rpool/user 192.168.89.0/24(rw,sync,no_subtree_check)
  '';

  time.timeZone = "Europe/London";

  networking = {
    useDHCP = false;
    interfaces = {
      enp2s0.useDHCP = true;
      enp3s0.useDHCP = true;
    };
  };

  # service wakeonlan didn't work for me
  systemd.services."enable-wol" = {
    enable = true;
    unitConfig = {
      Requires = "network.target";
      After = "network-online.target";
    };
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${wolScript}";
    };
    wantedBy = [ "multi-user.target" ];
  };

  environment.systemPackages = with pkgs; [ printrun ];

  system.stateVersion = "21.03";

}


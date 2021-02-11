# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../base.nix
      ../../security.nix
      ../../ssh.nix
      ../../zfs.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "server2";
    hostId = "16ab23fb";
    extraHosts = builtins.readFile ../../extra_hosts;
    firewall.allowedTCPPorts = [ 111 2049 4045 20048 ];
    firewall.allowedUDPPorts = [ 111 2049 4045 20048 ];
  };

  # NFS server
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /rpool/extra 192.168.89.0/24(rw,sync,no_subtree_check)
  '';

  time.timeZone = "Europe/London";

  networking.useDHCP = false;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.enp3s0.useDHCP = true;

  # users
  users.users.user = {
    isNormalUser = true;
    uid = 1001;
    extraGroups = [ "dialout" ];
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [ r8125 ];

  environment.systemPackages = with pkgs; [
    printrun
  ];

  system.stateVersion = "21.03";

}


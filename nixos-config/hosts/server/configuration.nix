# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../base.nix
      ../../security.nix
      ../../ssh.nix
      ../../zfs.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "zfs" ];

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking = {
    hostName = "server";
    hostId = "817bc811";
    networkmanager.enable = true;
    extraHosts = builtins.readFile ../../extra_hosts;
    useDHCP = false;
    interfaces.enp0s31f6.useDHCP = true;
    interfaces.enp2s0f0.useDHCP = true;
    interfaces.enp2s0f1.useDHCP = true;
    interfaces.enp3s0f0.useDHCP = true;
    interfaces.enp3s0f1.useDHCP = true;
    interfaces.wlp0s20f0u1.useDHCP = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Londom";

  # List services that you want to enable:

  # users
  users.users.user = {
    isNormalUser = true;
    uid = 1001;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


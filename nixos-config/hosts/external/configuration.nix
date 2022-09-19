# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../base.nix
    ./../../coms.nix
    ./../../desktop-x.nix
    #./../../electronics.nix
    ./../../overrides.nix
    ./../../security.nix
    ./../../security-options.nix
    #./../../ssh.nix
    ./../../user.nix
    ./../../virt.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" "zfs" ];

  time.timeZone = "Europe/London";

  networking = {
    hostName = "laptop1";
    networkmanager.enable = true;
    extraHosts = builtins.readFile ../../extra_hosts;
    hostId = "4e28bfaf";
  };

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}


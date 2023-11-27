# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../base.nix
    ../../coms.nix
    ../../desktop-x.nix
    ../../electronics.nix
    ../../kernel-mod.nix
    ../../kernel-pkgs.nix
    ../../music.nix
    ../../overrides.nix
    ../../security.nix
    ../../security-options.nix
    ../../user.nix
    ../../virt.nix
    ../../work.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  boot.supportedFilesystems = [ "nfs" "ntfs" "zfs" ];
  nixpkgs.config.allowBroken = true;

  #services.printing.enable = true;
  #services.printing.drivers = [ pkgs.hplip pkgs.brlaser pkgs.brgenml1lpr ];

  # Services
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # Networking
  networking = {
    hostName = "lat5400";
    hostId = "4e28bfaf";
    extraHosts = builtins.readFile ../../extra_hosts;
    networkmanager.enable = true;
  };

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    tor-browser-bundle-bin
    exercism
    weka
  ];

  # Set your time zone.
  time.timeZone = "Europe/London";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}


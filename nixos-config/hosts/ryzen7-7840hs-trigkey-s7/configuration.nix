# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../base.nix
      ../../comm.nix
      ../../desktop-x.nix
      ../../electronics.nix
      ../../erp.nix
      ../../kernel-mod.nix
      ../../kernel-pkgs.nix
      ../../music.nix
      ../../overrides.nix
      ../../radicle.nix
      ../../security.nix
      ../../ssh.nix
      ../../user.nix
      ../../work.nix
      ../../virt.nix
    ];

  #boot.kernelPackages = pkgs.linuxPackages_6_11;
  powerManagement = {
    cpuFreqGovernor = "performance";
    cpufreq.max = 3800000;
  };
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "nfs" "ntfs" "zfs" "bcachefs" ];

  security.pam = {
    services.i3lock = {
      unixAuth = true;
      u2fAuth = true;
    };
    services.login = {
      unixAuth = true;
      u2fAuth = true;
    };
    services.sshd = {
      googleAuthenticator.enable = true;
    };
    services.sudo = {
      unixAuth = true;
      u2fAuth = true;
    };
  };
  # speed up boot a bit
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  networking = {
    hostName = "ryzen7-7840hs-trigkey-s7";
    hostId = "0ed59dab";
    extraHosts = builtins.readFile ../../extra_hosts;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    discord
    eclipses.eclipse-java
    jdk11
    tor-browser
    # weka
  ];

  # Set your time zone.
  time.timeZone = "Europe/London";
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

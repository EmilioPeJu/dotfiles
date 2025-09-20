# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, epnix, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../base.nix
      ../../desktop-way.nix
      ../../electronics.nix
      ../../erp.nix
      ../../kernel-pkgs.nix
      ../../security.nix
      ../../ssh.nix
      ../../overrides.nix
      ../../user.nix
      ../../work.nix
      ../../virt.nix
      ../../virt-net.nix
      ../../yggdrasil.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_6_15;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ext4" "ntfs" "zfs" ];

  # Reduce maximum CPU frequency to improve reliability and CPU life
  powerManagement = {
    cpuFreqGovernor = "performance";
    cpufreq.max = 3500000;
  };

  systemd.tmpfiles.rules = [
    # Stop charging battery at 80% to prolong battery life.
    "w /sys/class/power_supply/BAT1/charge_control_end_threshold - - - - 80"
  ];

  networking = {
    hostName = "vivobook-s-14";
    hostId = "24ab83ff";
  };

  security.pam = {
    #u2f.settings.debug = true;
    services.swaylock = {
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

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Packages
  environment.systemPackages = [
    epnix.packages.x86_64-linux.epics-base
  ];

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


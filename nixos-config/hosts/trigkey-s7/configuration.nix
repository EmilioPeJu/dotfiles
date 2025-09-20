# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../3dprinting.nix
      #../../android.nix
      ../../base.nix
      ../../comm.nix
      ../../desktop-way.nix
      ../../electronics.nix
      ../../kernel-mod.nix
      ../../music.nix
      ../../overrides.nix
      ../../security.nix
      ../../ssh.nix
      ../../user.nix
      ../../virt.nix
      ../../virt-net.nix
      ../../yggdrasil.nix
    ];

  #boot.kernelPackages = pkgs.linuxPackages_6_15;
  powerManagement = {
    cpuFreqGovernor = "performance";
    cpufreq.max = 3800000;
  };

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

  networking = {
    hostName = "ryzen7-7840hs-trigkey-s7";
    hostId = "0ed59dab";
    extraHosts = builtins.readFile ../../extra_hosts;
  };

  environment.systemPackages = with pkgs; [
    discord
    element-desktop
    steam
    tdesktop
    tor-browser
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

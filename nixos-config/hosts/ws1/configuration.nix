# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../base.nix
    ../../coms.nix
    ../../desktop-way.nix
    ../../electronics.nix
    ../../overrides.nix
    ../../security.nix
    ../../security-options.nix
    ../../user.nix
    ../../virt.nix
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nixpkgs.config.allowUnfree = true;

  # Kernel
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" "dvb_usb_rtl28xxu" ];
  boot.kernelParams = [
    "initcall_debug=1"
    #  "apic=debug"
    #  "debug"
    #  "loglevel=7"
    "pnp.debug=1"
    #  "sched_debug"
    #  "trace_event=i2c_read"
  ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.initrd.postMountCommands = "${pkgs.zfs}/bin/zpool import -al";
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 video_nr=10 card_label="OBS Video Source"
  '';
  boot.supportedFilesystems = [ "ntfs" "zfs" ];
  nixpkgs.config.allowBroken = true;

  #services.printing.enable = true;
  #services.printing.drivers = [ pkgs.hplip pkgs.brlaser pkgs.brgenml1lpr ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;

  # Services
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
  services.xserver.videoDrivers = [ "amdgpu" ];
  # Networking
  networking = {
    hostName = "ws1";
    hostId = "4e28bfae";
    extraHosts = builtins.readFile ../../extra_hosts;
    networkmanager.enable = false;
    useDHCP = false;
    interfaces.enp4s0.useDHCP = true;
    interfaces.enp2s0f0u5.useDHCP = true;
  };

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


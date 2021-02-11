# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../base.nix
    ../../desktop.nix
    ../../electronics.nix
    ../../security.nix
    ../../virt.nix
    ../../zfs.nix
  ];

  boot.kernelParams = ["zfs.zfs_arc_max=12884901888"];
  nixpkgs.config.allowBroken = true;
  # Use the systemd-boot EFI boot loader.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip pkgs.brlaser pkgs.brgenml1lpr ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" "dvb_usb_rtl28xxu" ];

  # Networking
  networking = {
    hostName = "gamer"; # Define your hostname.
    hostId = "4e28bfae";
    networkmanager.enable = true;
    extraHosts = builtins.readFile ../../extra_hosts;
    useDHCP = false;
  };

  # gnupg agent
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # User
  users.users.user = {
    uid = 1001;
    isNormalUser = true;
    extraGroups = [
      "systemd-journal"
      "audio"
      "dialout"
      "video"
      "plugdev"
    ];
    packages = with pkgs; [
      discord
      #nomachine-client
      openscad
      skypeforlinux
      slack
      steam
      teams
      vscode-with-extensions
      zoom-us
    ];
  };
  # discord, vscode ... require it
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}


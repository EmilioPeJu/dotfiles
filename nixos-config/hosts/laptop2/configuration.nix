# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let dirty = (import ../../dirty.nix { });
in {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../base.nix
    ../../desktop.nix
    ../../security.nix
    ../../ssh.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "nodev";
  boot.supportedFilesystems = [ "ntfs" "zfs" ];

  # this laptop has coreboot with grub2 as payload and
  # it loads the configuration file at /boot/loader.cfg
  system.activationScripts = {
    loader = {
      text = ''
        cp -f /boot/grub/grub.cfg /boot/loader.cfg
      '';
      deps = [ ];
    };
  };
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.

  networking = {
    hostName = "laptop2";
    hostId = "f36d99d7";
    networkmanager.enable = true;
    extraHosts = builtins.readFile ../../extra_hosts;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # List services that you want to enable:

  # Users
  users.users = {
    user = {
      isNormalUser = true;
      hashedPassword = dirty.userHash;
      extraGroups = [ "audio" "dialout" "networkmanager" ];
      uid = 1001;
    };
    root = { hashedPassword = dirty.rootHash; };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


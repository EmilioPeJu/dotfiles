# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../base.nix
    ../../desktop-x.nix
    ../../overrides.nix
    ../../ssh.nix
    ../../user.nix
    ../../virt.nix
  ];

  powerManagement.cpuFreqGovernor = "powersave";

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
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

  networking = {
    hostName = "x230";
    hostId = "f36d99d7";
    extraHosts = builtins.readFile ../../extra_hosts;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


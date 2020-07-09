# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../soft.nix
    ];
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user" ];
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" ];
  # Modified Linux
  #  boot.kernelPatches = [ {
  #    name = "debug-on";
  #    patch = null;
  #    extraConfig = ''
  #      DEBUG_INFO y
  #      KGDB y
  #      GDB_SCRIPTS y
  #    '';
  #  } ];

  # Networking
  networking = {
    hostName = "gamer"; # Define your hostname.
    networkmanager.enable = true;
    extraHosts = builtins.readFile ../../extra_hosts;
    useDHCP = false;
    interfaces.enp3s0.useDHCP = true;
    interfaces.wlp2s0.useDHCP = true;
  };

  # Services
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    libinput.enable = true;
    wacom.enable = true;
    displayManager.startx.enable = true;
  };
  services.avahi.enable = false;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  # Users
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "audio" "libvirtd" "kvm" "vboxusers" ];
    uid = 1001;
  };

  security.sudo.enable = true;
  security.sudo.configFile = ''
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/mount
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/umount
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/nmtui
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}


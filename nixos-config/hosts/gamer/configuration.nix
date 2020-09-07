# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../base.nix
    ../../coms.nix
    ../../desktop.nix
    # ../../music.nix
    ../../security.nix
    ../../virt.nix
    ../../zfs.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.editor = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" "dvb_usb_rtl28xxu" ];
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
    hostId = "4e28bfae";
    networkmanager.enable = true;
    extraHosts = builtins.readFile ../../extra_hosts;
    useDHCP = false;
    interfaces.enp3s0.useDHCP = true;
    interfaces.wlp2s0.useDHCP = true;
  };

  # Wireguard
  # this line is only used to easily enable/disable wireguard
  networking.wireguard.enable = true;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "192.168.90.2/24" ];
      privateKeyFile = "/home/user/.wireguard/peerprivate";
      peers = [{
        publicKey = builtins.replaceStrings [ "\n" ] [ "" ]
          (builtins.readFile /home/user/.wireguard/public);
        presharedKeyFile = "/home/user/.wireguard/psk";
        allowedIPs =
          [ "192.168.89.0/24" "192.168.1.227/32" "192.168.1.228/32" ];
        endpoint = builtins.replaceStrings [ "\n" ] [ "" ]
          (builtins.readFile /home/user/.wireguard/endpoint);
        persistentKeepalive = 25;
      }];
    };
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
      "libvirtd"
      "kvm"
      "vboxusers"
      "docker"
      "dialout"
      "video"
    ];
    packages = with pkgs; [
      discord
      nomachine-client
      plan9port
      skypeforlinux
      slack
      steam
      teams
      vscode
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


# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../base.nix
      ../../desktop.nix
      ../../ssh.nix
      ../../security.nix
      ../../zfs.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "cryptkeeper";
    hostId = "974460af";
    networkmanager.enable = true;
    extraHosts = builtins.readFile ../../extra_hosts;
    useDHCP = false;
    interfaces.eno1.useDHCP = true;
    interfaces.wlp3s0.useDHCP = true;
  };

  # Wireguard
  # this line is only used to easily enable/disable wireguard
  networking.wireguard.enable = true;
  networking.firewall = {
      allowedUDPPorts = [ 51820 ];
  } ;

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "192.168.90.1/24" ];
      listenPort = 51820;
      postSetup = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i wlp3s0 -o eno1 -j DROP
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.90.0/24 -o eno1 -j MASQUERADE
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 192.168.90.0/24 -o wlp3s0 -j MASQUERADE
        ${pkgs.procps}/bin/sysctl net.ipv4.ip_forward=1
      '';
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i wlp3s0 -o eno1 -j DROP
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 192.168.90.0/24 -o eno1 -j MASQUERADE
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 192.168.90.0/24 -o wlp2s0 -j MASQUERADE
        ${pkgs.procps}/bin/sysctl net.ipv4.ip_forward=0
      '';
      privateKeyFile = "/home/user/.wireguard/private";
      peers = [
        {
          publicKey = builtins.replaceStrings ["\n"] [""] (builtins.readFile /home/user/.wireguard/peerpublic);
          presharedKeyFile = "/home/user/.wireguard/psk";
          allowedIPs = [ "192.168.90.2/32" ];
        }
      ];
    };
  };

  time.timeZone = "Europe/London";

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "audio" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}


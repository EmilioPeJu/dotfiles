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
      ../../kernel-pkgs.nix
      ../../security.nix
      ../../ssh.nix
      ../../overrides.nix
      ../../user.nix
      ../../work.nix
      ../../virt.nix
      ../../virt-net.nix
      #../../yggdrasil.nix
      ../../zfs-compatible-kernel.nix
      ../../3dprinting.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ext4" "ntfs" "zfs" ];

  # Reduce maximum CPU frequency to improve reliability and CPU life
  #powerManagement = {
  #  cpuFreqGovernor = "performance";
  #  cpufreq.max = 3500000;
  #};

  systemd.tmpfiles.rules = [
    # Stop charging battery at 80% to prolong battery life.
    "w /sys/class/power_supply/BAT0/charge_control_end_threshold - - - - 80"
  ];

  networking = {
    hostName = "thinkpad-t14";
    hostId = "24ab83ff";
  };

  security.pam = {
    services.sshd = {
      googleAuthenticator.enable = true;
    };
  };

  # speed up boot a bit
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # NFS server
  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /home/user/work 192.168.2.0/24(rw,sync,no_subtree_check)
    /home/user/dotfiles 192.168.2.0/24(rw,sync,no_subtree_check)
  '';
  networking.firewall.allowedTCPPorts = [ 2049 8000 9999 8888 ];
  # don't start daemon at boot time
  systemd.services.nfs-server.wantedBy = lib.mkForce [ ];

  # Packages
  environment.systemPackages = with pkgs; [
    epnix.packages.x86_64-linux.epics-base
    hev-socks5-tunnel
    steam
    telegram-desktop
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


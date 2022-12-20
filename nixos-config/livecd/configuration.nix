{ config, pkgs, ... }:

let dirty = (import ../dirty.nix { });
in {
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>
  ];
  environment.systemPackages = with pkgs; [
    curl
    diskscan
    ddrescue
    dhcpcd
    dmidecode
    ethtool
    file
    gnufdisk
    hddtemp
    hdparm
    htop
    inetutils
    iproute2
    lshw
    lsof
    ncdu
    pciutils
    python3
    radare2
    ranger
    smartmontools
    tmux
    udev
    usbutils
    watch
    wol
    wpa_supplicant
    # Compression
    gzip
    unzip
  ];
  networking.hostName = "machine";
  networking.networkmanager.enable = false;
  # users
  users.users = {
    nixos = {
      uid = 1001;
      extraGroups = [ "dialout" "wheel" ];
    };
    root = { hashedPassword = dirty.rootHash; };
  };
}


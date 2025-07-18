{ config, lib, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };
  environment.systemPackages = with pkgs; [
    bashmount
    file
    htop
    iotop
    lsof
    ncdu
    neovim
    nnn
    nvme-cli
    pass
    psmisc
    pulsemixer
    ripgrep
    rsync
    sleuthkit
    tio
    tmux
    watch
    wget
    # Compression
    archivemount
    gzip
    unzip
    zip
    # Encryption
    openssl
    pinentry-curses
    # FS and disk
    hdparm
    inotify-tools
    nfs-utils
    # HW
    dmidecode
    hddtemp
    lm_sensors
    lshw
    pciutils
    smartmontools
    udev
    usbutils
    # Management
    remind
    # Net
    curl
    dnsmasq
    dnsutils
    ethtool
    iperf
    iwd
    socat
    traceroute
    weechat
    wireshark
    wol
    radare2
    strace
    valgrind
    yara
  ];
}

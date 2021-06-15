{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
  nixpkgs.config.packageOverrides = pkgs:
    {
      libunity = (pkgs.callPackage ./pkgs/libunity {});
    };
  # Some packages like coreutils, glibc or openssh are
  # already pulled in system-path
  environment.systemPackages = with pkgs; [
    ansible
    atool
    bashmount
    ccls
    cifs-utils
    clamav
    ddrescue
    direnv
    direvent
    entr
    espeak
    file
    fzf
    gtk3
    htop
    iftop
    indent
    iotop
    jq
    killall
    lsof
    manpages
    ncdu
    neovim
    pass
    progress
    psmisc
    pulsemixer
    python3Packages.pyserial
    ranger
    ripgrep
    rsync
    starship
    tmux
    translate-shell
    tree
    ts
    watch
    wget
    xcftools
    youtube-dl
    # Compression
    archivemount
    gzip
    p7zip
    unzip
    zip
    # Encryption
    gnupg
    openssl
    pinentry-curses
    # FS and disk
    gparted
    hdparm
    inotify-tools
    nfs-utils
    udisks
    xfsprogs
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
    timetrap
    wyrd
    # Monitor
    atop
    # Net
    curl
    deluge
    dnsmasq
    dnsutils
    dynamips
    ethtool
    gns3-server
    inetutils
    iperf
    junkie
    netcat-gnu
    netsniff-ng
    nmap
    openvswitch
    proxychains
    redsocks
    sshfs
    socat
    step-cli
    traceroute
    ubridge
    vpcs
    w3m
    websocat
    weechat
    wireguard
    wireshark
    wol
    wpa_supplicant
    # NIX related
    cachix
    nixfmt
    nixpkgs-fmt
    nixpkgs-lint
    nix-universal-prefetch
    patchelf
    # Players
    ffmpeg-full
    mpd
    mpc_cli
    mpv-with-scripts
    ncmpc
    # Programming/Debugging/Tracing
    automake
    binutils
    config.boot.kernelPackages.perf
    cscope
    ctags
    flex
    gcc
    gdb
    gitAndTools.gitFull
    gnumake
    #kernelshark
    kexectools
    libunity
    linuxPackages.bpftrace
    ltrace
    meson
    ninja
    nodejs
    openjdk
    perf-tools
    pkgconfig
    radare2
    rustfmt
    rustup
    sloccount
    strace
    tig
    trace-cmd
    valgrind
    yacc
    yasm
    yara
    zeal
    # Python
    jupyter
    (python3.withPackages (pp: [
      pp.numpy
      pp.matplotlib
      pp.ipykernel
      pp.mypy
      pp.pip
      pp.pycodestyle
      pp.pygame
      pp.pylint
      pp.pynvim
      pp.pyserial
      pp.pyzmq
      pp.scapy
      pp.setuptools
      pp.scipy
      pp.virtualenv
    ]))
    # Security
    metasploit
    python3Packages.binwalk-full
  ];

  security.wrappers = {
    ubridge = {
      source = "${pkgs.ubridge}/bin/ubridge";
      owner = "nobody";
      group = "nobody";
      capabilities = "cap_net_admin,cap_net_raw+ep";
    };
  };
}

{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
  # Some packages like coreutils, glibc or openssh are
  # already pulled in system-path
  environment.systemPackages = with pkgs; [
    ansible
    atool
    bashmount
    cifs-utils
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
    iotop
    jq
    killall
    lsof
    mako
    manpages
    matrix-synapse
    ncdu
    pass
    progress
    psmisc
    pulsemixer
    python38Packages.pyserial
    ranger
    ripgrep
    rsync
    starship
    tmux
    tree
    ts
    ums
    (vimHugeX.override { python = python3; })
    watch
    wget
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
    lshw
    pciutils
    smartmontools
    udev
    usbutils
    # Management
    calcurse
    python38Packages.bugwarrior
    remind
    taskwarrior
    vit
    wyrd
    # Monitor
    atop
    # Net
    boringtun
    deluge
    dnsutils
    dynamips
    filezilla
    gns3-server
    inetutils
    iperf
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
    cscope
    ctags
    flex
    gcc
    gdb
    gitAndTools.gitFull
    gnumake
    kernelshark
    nodejs
    openjdk
    oprofile
    perf-tools
    pkgconfig
    radare2
    rustup
    sloccount
    strace
    swt
    tig
    trace-cmd
    valgrind
    yacc
    yasm
    yara
    zeal
    # Python
    jupyter
    (python3Full.withPackages (pp: [
      pp.numpy
      pp.matplotlib
      pp.ipykernel
      pp.pip
      pp.pycodestyle
      pp.pygame
      pp.pyzmq
      pp.setuptools
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

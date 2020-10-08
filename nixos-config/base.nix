{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
  # Some packages like coreutils, glibc or openssh are
  # already pulled in system-path
  environment.systemPackages = with pkgs; [
    ansible
    atool
    bashmount
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
    # Electronics
    ngspice
    pulseview
    sigrok-cli
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
    taskwarrior
    vit
    # Monitor
    atop
    # Net
    deluge
    dnsutils
    filezilla
    inetutils
    iperf
    netcat-gnu
    nmap
    openvswitch
    proxychains
    sshfs
    socat
    step-cli
    traceroute
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
    yacc
    gcc
    gdb
    gitAndTools.gitFull
    gnumake
    kernelshark
    nodejs
    openjdk
    openocd
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
      pp.pyzmq
      pp.setuptools
      pp.virtualenv
    ]))
    # Security
    metasploit
    python3Packages.binwalk-full
  ];
}

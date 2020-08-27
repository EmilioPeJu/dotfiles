{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
  # Some packages like coreutils, glibc or openssh are
  # already pulled in system-path
  environment.systemPackages = with pkgs; [
    ansible
    atool
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
    ncdu
    pass
    progress
    psmisc
    pulsemixer
    python38Packages.pyserial
    ranger
    ripgrep
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
    # Net
    deluge
    dnsutils
    filezilla
    inetutils
    iperf
    netcat-gnu
    nmap
    proxychains
    sshfs
    socat
    traceroute
    websocat
    weechat
    wireguard
    wireshark
    wol
    wpa_supplicant
    # NIX related
    cachix
    nixpkgs-fmt
    nixpkgs-lint
    nix-prefetch-git
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
    jdk
    kernelshark
    nodejs
    openocd
    oprofile
    perf-tools
    pkgconfig
    radare2
    rustup
    sloccount
    tig
    trace-cmd
    valgrind
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
  ];
}

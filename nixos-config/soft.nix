{ config, lib, pkgs, ... }:

{
  # Some packages like coreutils, glibc or openssh are
  # already pulled in system-path
  environment.systemPackages = with pkgs; [
    anki
    ansible
    atool
    ddrescue
    direnv
    dmidecode
    espeak
    file
    firefox
    fzf
    htop
    iftop
    iotop
    killall
    libreoffice
    lsof
    minicom
    ncdu
    pass
    pulsemixer
    ranger
    taskwarrior
    tmux
    (vimHugeX.override { python = python3; })
    vym
    watch
    wget
    youtube-dl
    zsh
    # Compression
    gzip
    unzip
    zip
    # Email
    thunderbird
    # Encryption
    gnupg
    openssl
    pinentry-curses
    # Desktop
    bluez-tools
    conky
    dmenu
    dunst
    dwm
    feh
    joplin-desktop
    gnome3.gnome-terminal
    gnome3.gnome-tweaks
    gnome3.gnome-notes
    maim
    pavucontrol
    scrot
    slock
    st
    xclip
    # Docs
    fbreader
    mupdf
    texlive.combined.scheme-basic
    texstudio
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
    pciutils
    udev
    usbutils
    # Images
    gimp
    gphoto2
    graphviz
    imagemagick
    # Keyboard
    xorg.setxkbmap
    xorg.xev
    xorg.xkbcomp
    xorg.xmodmap
    # Messaging
    qtox
    tdesktop
    # Music
    audacity
    lmms
    musescore
    pianobooster
    solfege
    sox
    # Net
    deluge
    dnsutils
    filezilla
    iperf
    nmap
    socat
    traceroute
    weechat
    wireguard
    wireshark
    wpa_supplicant
    # NIX related
    cachix
    nixpkgs-fmt
    nixpkgs-lint
    nix-prefetch-git
    patchelf
    # Programming/Debugging/Tracing
    binutils
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
    trace-cmd
    valgrind
    zeal
    # Python
    jupyter
    python3
    python38Packages.ipykernel
    python38Packages.pip
    python38Packages.pycodestyle
    python38Packages.setuptools
    python38Packages.virtualenv
    # Media
    mpv
    playerctl
    vlc
    # VM
    qemu
    virtualbox
  ];
}

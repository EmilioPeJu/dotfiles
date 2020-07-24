{ config, lib, pkgs, ... }:

{
  # Some packages like coreutils, glibc or openssh are
  # already pulled in system-path
  nixpkgs.overlays = [
    (self: super:
      {
        gnuradio = (super.gnuradio.override {
          python = (super.python2.withPackages (pp: [ pp.pygtk ]));
        });
      }
    )
  ];
  environment.systemPackages = with pkgs; [
    anki
    ansible
    atool
    ddrescue
    direnv
    direvent
    dmidecode
    entr
    espeak
    file
    firefox
    fontforge
    freerdp
    fzf
    glances
    grim
    gtk3
    htop
    iftop
    iotop
    i3status
    jq
    killall
    libreoffice
    lsof
    mako
    manpages
    mutt-with-sidebar
    ncdu
    pass
    plan9port
    progress
    psmisc
    pulsemixer
    qt5.full
    python38Packages.pyserial
    ranger
    sway
    tmux
    tree
    ts
    ums
    (vimHugeX.override { python = python3; })
    vym
    watch
    wget
    wine
    youtube-dl
    zsh
    # Compression
    archivemount
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
    maim
    pavucontrol
    scrot
    slock
    st
    sxiv
    xorg.transset
    xorg.xkill
    xclip
    xcompmgr
    # Docs
    fbreader
    mupdf
    sent
    texlive.combined.scheme-basic
    texstudio
    zathura
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
    # Images
    gimp
    gphoto2
    graphviz
    imagemagick
    krita
    # Keyboard
    xorg.setxkbmap
    xorg.xev
    xorg.xkbcomp
    xorg.xmodmap
    # Management
    python38Packages.bugwarrior
    taskwarrior
    vit
    # Messaging
    qtox
    tdesktop
    # Music
    audacity
    lmms
    mpd
    mpc_cli
    musescore
    ncmpc
    pianobooster
    solfege
    sox
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
    wpa_supplicant
    # NIX related
    cachix
    nixpkgs-fmt
    nixpkgs-lint
    nix-prefetch-git
    patchelf
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
    # Radio
    #(gnuradio-with-packages.override { python = python2; })
    gnuradio-with-packages
    gr-osmosdr
    gqrx
    rtl-sdr
    # Python
    jupyter
    (python3Full.withPackages (pp: [
      pp.ipykernel
      pp.pip
      pp.pycodestyle
      pp.setuptools
      pp.virtualenv
    ]))
    # Media
    mpv-with-scripts
    olive-editor
    playerctl
    # VM
    qemu
    # VOIP
    linphone
    sipp
    sipsak
  ];

  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
}

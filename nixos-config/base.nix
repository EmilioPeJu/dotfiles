{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
  nixpkgs.config.packageOverrides = pkgs: {
    #libunity = (pkgs.callPackage ./pkgs/libunity { });
    slock = (pkgs.slock.override {
      conf = builtins.readFile ./slock/config.h;
    }).overrideAttrs
      (oldAttrs: { patches = [ ./slock/slock-unlock_screen-1.4.diff ]; });
    dwm = (pkgs.dwm.override {
      conf = builtins.readFile ./dwm/config.h;
      patches = [ ./dwm/dwm-scratchpad-6.2.diff ];
    });
    st = (pkgs.st.override {
      conf = builtins.readFile ./st/config.h;
      patches = [
        ./st/st-alpha-0.8.2.diff
        ./st/st-externalpipe-0.8.4.diff
        ./st/st-scrollback-20200419-72e3f6c.diff
      ];
    });
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
    expect
    fakeroot
    file
    fzf
    gtk3
    htop
    iftop
    indent
    iotop
    ipmitool
    jq
    killall
    lsof
    man-pages
    ncdu
    neovim
    openipmi
    pass
    progress
    psmisc
    powertop
    pulsemixer
    ranger
    ripgrep
    rsync
    starship
    tmux
    translate-shell
    tree
    ts
    vis
    #tuna
    watch
    wget
    xcftools
    yt-dlp
    zellij
    # Compression
    archivemount
    gzip
    p7zip
    unrar
    unzip
    zip
    # Encryption
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
    tunctl
    ubridge
    vde2
    vpcs
    w3m
    websocat
    weechat
    wireshark
    wol
    wpa_supplicant
    # NIX related
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
    bpftool
    config.boot.kernelPackages.bpftrace
    config.boot.kernelPackages.cpupower
    clang-tools
    config.boot.kernelPackages.perf
    cscope
    ctags
    flex
    gcc
    gdb
    gitAndTools.gitFull
    gnumake
    julia-bin
    #kernelshark
    kexectools
    libunity
    ltrace
    meson
    ninja
    nodejs
    openjdk
    perf-tools
    pforth
    pkgconfig
    radare2
    #riscv-toolchain
    rustfmt
    rustup
    scilab-bin
    sloccount
    strace
    swiProlog
    tig
    trace-cmd
    valgrind
    yacc
    yasm
    yara
    zeal
    # Python
    (python3.withPackages (pp: [
      pp.beautifulsoup4
      pp.dbus-python
      pp.jupyterlab
      pp.jupyter-packaging
      pp.jupytext
      pp.numpy
      pp.matplotlib
      pp.mypy
      pp.pip
      pp.pycodestyle
      pp.pydbus
      pp.pygame
      pp.pylint
      pp.pynvim
      pp.pygobject3
      pp.pyserial
      pp.pytest
      pp.pyzmq
      pp.requests
      pp.scapy
      pp.setuptools
      pp.scipy
      pp.virtualenv
    ]))
    # Security
    metasploit
    python3Packages.binwalk-full
  ];

  # gnupg agent
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
  };

  security.wrappers = {
    ubridge = {
      source = "${pkgs.ubridge}/bin/ubridge";
      owner = "nobody";
      group = "nobody";
      capabilities = "cap_net_admin,cap_net_raw+ep";
    };
  };
}

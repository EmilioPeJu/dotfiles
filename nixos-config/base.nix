{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
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
    mutt
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
    zsh
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
    factor-lang
    flex
    gcc
    gdb
    gitAndTools.gitFull
    gnumake
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
    pmbootstrap
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
    (python3.withPackages (import ./python-packages.nix))
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

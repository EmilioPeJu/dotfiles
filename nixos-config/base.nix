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
    nvme-cli
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
    clang-tools
    #clisp
    cscope
    ctags
    #factor-lang
    flex
    flyctl
    gcc
    gdb
    gitAndTools.gitFull
    gitui
    gnumake
    #julia-bin
    kexectools
    libunity
    #ltrace
    meson
    ninja
    perf-tools
    pforth
    pmbootstrap
    pkgconfig
    radare2
    rustfmt
    rustup
    #scilab-bin
    sloccount
    strace
    swiProlog
    valgrind
    yacc
    yasm
    yara
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

  programs.atop = {
    enable = true;
    netatop.enable = true;
  };
}

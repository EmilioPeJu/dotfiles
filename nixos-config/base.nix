{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
  networking = {
    hostFiles = [ ./extra_hosts ];
    networkmanager = {
      enable = true;
      #wifi.backend = "iwd";
    };
  };
  hardware.enableAllFirmware = true;
  services.sysstat.enable = true;
  environment.systemPackages = with pkgs; [
    acpica-tools
    aria2
    asciinema_3
    asciinema-agg
    asciinema-scenario
    atool
    autojump
    awscli2
    bashmount
    bat
    #bcachefs-tools
    bluetuith
    bpftrace
    brightnessctl
    broot
    btop
    buku
    ccls
    cifs-utils
    #clamav
    clibt
    copier
    cryptsetup
    diffsitter
    ddrescue
    direnv
    direvent
    #dmtx-utils
    entr
    espeak
    exfat
    exfatprogs
    expect
    fakeroot
    fd
    file
    fio
    fq
    fzf
    gcalcli
    gh
    #gocryptfs
    #goofys
    htop
    iftop
    inetutils
    indent
    iotop
    ipmitool
    ispell
    iw
    jq
    joshuto
    ki
    killall
    libfido2
    libu2f-host
    lf
    lsof
    lua
    man-pages
    mdadm
    mdcat
    msr
    neofetch
    neomutt
    nethogs
    ncdu
    neovim
    neovim-remote
    nftables
    nnn
    nvme-cli
    ollama
    openipmi
    pass
    poke
    progress
    psmisc
    powertop
    pulsemixer
    pyright
    qrrs
    #qrscan
    qrtool
    ranger
    rclone
    ripgrep
    rsync
    sc-im
    sleuthkit
    snapraid
    #solo2-cli
    sosreport
    starship
    stress-ng
    systemd-manager-tui
    tdf
    tio
    tmsu
    tmux
    translate-shell
    tree
    tree-sitter
    ts
    unar
    unixtools.xxd
    #tuna
    watch
    wget
    #xcftools
    yt-dlp
    zsh
    # Compression
    archivemount
    gzip
    p7zip
    unrar
    unzip
    zip
    # Duplicates
    #dupeguru
    jdupes
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
    hwloc
    lm_sensors
    lshw
    pciutils
    smartmontools
    udev
    usbutils
    # Net
    curl
    deluge
    dnsmasq
    dnsutils
    #dynamips
    ethtool
    #gns3-gui
    #gns3-server
    iperf
    iwd
    #junkie
    #openvswitch
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
    # nix related
    nixfmt
    patchelf
    # Players
    ffmpeg-full
    mpd
    mpc
    mpv
    ncmpc
    # Programming/Debugging/Tracing
    automake
    binutils
    bison
    clang-tools
    cmake
    #clisp
    codespell
    cscope
    ctags
    debootstrap
    devmem2
    flex
    flyctl
    gcc
    gdb
    gef
    gitFull
    git-filter-repo
    git-repo
    gitui
    git-worktree-switcher
    gnumake
    jdk8
    kas
    kexec-tools
    lazygit
    #ltrace
    nasm
    meson
    msr-tools
    ninja
    #paxtest
    perf-tools
    pforth
    pmccabe
    pmbootstrap
    pkg-config
    radare2
    rdma-core
    rizin
    rr
    ruff
    #rust-analyzer
    rustup
    #scilab-bin
    strace
    #swiProlog
    sysstat
    valgrind
    #virtme-ng
    yasm
    yara
    # Python
    (python3.withPackages (import ./python-packages.nix))
    # AI
    aichat
    aider-chat-full
    claude-code
    onnxruntime
    plandex
    plandex-server
    # Security
    libu2f-host
    pam_u2f
    # Productivity
    remind
    tasksh
    taskwarrior3
    timetrap
    timewarrior
    vit
    wyrd
    # Typing
    #smassh
    #ttyper
  ];

  # gnupg agent
  programs.gnupg.agent.enable = true;

  security.wrappers = {
    ubridge = {
      source = "${pkgs.ubridge}/bin/ubridge";
      owner = "root";
      group = "root";
      capabilities = "cap_net_admin,cap_net_raw+ep";
    };
  };
}

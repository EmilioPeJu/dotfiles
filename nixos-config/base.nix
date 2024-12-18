{ config, lib, pkgs, ... }:

{
  documentation.dev.enable = true;
  networking.networkmanager.enable = true;
  environment.systemPackages = with pkgs; [
    #ansible
    atool
    bashmount
    bpftrace
    broot
    btop
    buku
    ccls
    cifs-utils
    clamav
    copier
    diffsitter
    ddrescue
    direnv
    direvent
    entr
    espeak
    expect
    fakeroot
    fdupes
    file
    fq
    fzf
    htop
    iftop
    inetutils
    indent
    iotop
    ipmitool
    ispell
    jq
    joshuto
    killall
    libu2f-host
    lf
    lsof
    lua
    mdcat
    neofetch
    neomutt
    ncdu
    neovim
    neovim-remote
    nftables
    nnn
    nvme-cli
    openipmi
    pass
    poke
    progress
    psmisc
    powertop
    pulsemixer
    qemu
    ranger
    rclone
    ripgrep
    rsync
    sleuthkit
    starship
    tio
    tmsu
    tmux
    translate-shell
    tree
    tree-sitter
    ts
    unixtools.xxd
    vis
    #tuna
    watch
    wget
    wyrd
    xcftools
    yt-dlp
    zsh
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
    junkie
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
    wpa_supplicant
    # NIX related
    nixfmt-rfc-style
    patchelf
    # Players
    ffmpeg-full
    mpd
    mpc_cli
    mpv
    ncmpc
    # Programming/Debugging/Tracing
    automake
    binutils
    bison
    clang-tools
    cmake
    #clisp
    cscope
    ctags
    flex
    flyctl
    gcc
    gdb
    gef
    gitAndTools.gitFull
    git-repo
    gitui
    gnumake
    kexec-tools
    lazygit
    #ltrace
    meson
    ninja
    perf-tools
    pforth
    pmbootstrap
    pkg-config
    radare2
    rr
    rustup
    #scilab-bin
    sloccount
    strace
    #swiProlog
    valgrind
    yasm
    yara
    # Python
    (python3.withPackages (import ./python-packages.nix))
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

  programs.atop = {
    enable = true;
    netatop.enable = true;
  };
}

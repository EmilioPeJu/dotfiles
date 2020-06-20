# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.blacklistedKernelModules = [ "nvidia" "nouveau" ];
  # Modified Linux
  #  boot.kernelPatches = [ {
  #    name = "debug-on";
  #    patch = null;
  #    extraConfig = ''
  #      DEBUG_INFO y
  #      KGDB y
  #      GDB_SCRIPTS y
  #    '';
  #  } ];

  # Power management
  powerManagement.cpuFreqGovernor = "performance";

  # Networking
  networking = {
    hostName = "gamer"; # Define your hostname.
    networkmanager.enable = true;
    extraHosts = ''
      fd00:1111::7285:c2ff:fe75:b3c5 server.lan
      fd00:1111::3e97:eff:feab:3092 music.lan
    '';
    useDHCP = false;
    interfaces.enp3s0.useDHCP = true;
    interfaces.wlp2s0.useDHCP = true;
  };

  # Some packages like coreutils, glibc or openssh are
  # already pulled in system-path
  environment.systemPackages = with pkgs; [
    anki
    ansible
    direnv
    espeak
    file
    firefox
    fzf
    htop
    killall
    lsof
    ncdu
    pass
    ranger
    tmux
    vim
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
    pinentry
    # Desktop
    i3lock
    gnome3.gnome-terminal
    gnome3.gnome-tweaks
    gnome3.gnome-notes
    pavucontrol
    xclip
    # Docs
    fbreader
    mupdf
    texlive.combined.scheme-basic
    texstudio
    # FS
    gparted
    inotify-tools
    nfs-utils
    xfsprogs
    # HW
    pciutils
    udev
    usbutils
    # Images
    gphoto2
    imagemagick
    # Keyboard
    xorg.setxkbmap
    xorg.xev
    xorg.xkbcomp
    xorg.xmodmap
    # Messaging
    qtox
    tdesktop
    # Net
    deluge
    dnsutils
    iperf
    nmap
    wireguard
    wireshark
    # NIX related
    cachix
    nix-prefetch-git
    patchelf
    # Programming/Debugging/Tracing
    binutils
    flex
    yacc
    gcc
    gdb
    git
    gnumake
    jdk
    kernelshark
    nodejs
    oprofile
    perf-tools
    pkgconfig
    radare2
    rustup
    trace-cmd
    valgrind
    # Python
    jupyter
    python3
    python38Packages.ipykernel
    # Video
    vlc
    # VM
    qemu
    virtualbox
  ];

  programs.gnupg.agent = {
    enable = true;
  };

  # Services
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.libinput.enable = true;

  # Users
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "audio" ];
    uid = 1001;
  };

  security.sudo.enable = true;
  security.sudo.configFile = ''
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/mount
    user ALL=(ALL) NOPASSWD:/run/current-system/sw/bin/umount
  '';

  # mount points
  fileSystems = { 
    "/code" = {
        device = "/dev/disk/by-uuid/f75db471-f548-4695-8bc1-2e5e808fee39";
        fsType = "ext4";
      };
  };

  # VM
  # virtualisation = {
  #   virtualbox.host.enable = true;
  #   virtualbox.guest.enable = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}


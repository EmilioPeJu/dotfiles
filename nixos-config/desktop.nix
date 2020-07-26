{ config, lib, pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Services
  services.avahi.enable = false;
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    libinput.enable = true;
    wacom.enable = true;
    displayManager.startx.enable = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  programs.sway.enable = true;

  environment.systemPackages = with pkgs; [
    # Email
    thunderbird
    # Desktop
    anki
    bluez-tools
    conky
    dmenu
    dunst
    dwm
    feh
    firefox
    fontforge
    freerdp
    grim
    i3status
    joplin-desktop
    libreoffice
    maim
    pavucontrol
    qt5.full
    scrot
    slock
    st
    sway
    sxiv
    xclip
    xcompmgr
    xdotool
    xorg.transset
    xorg.xkill
    vym
    wine
    # Docs
    fbreader
    mupdf
    sent
    texlive.combined.scheme-basic
    texstudio
    zathura
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
    # Messaging
    qtox
    tdesktop
    # Media
    olive-editor
    playerctl
  ];

  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
}

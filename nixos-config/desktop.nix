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

  # Fonts
  fonts = {
    fontDir.enable = true;
    enableDefaultFonts = false;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "BigBlueTerminal"
          "BitstreamVeraSansMono"
          "DroidSansMono"
          "FiraCode"
          "SourceCodePro"
          "Ubuntu"
        ];
      })
      dejavu_fonts
      emojione
      freefont_ttf
      gyre-fonts
      hack-font
      liberation_ttf
      noto-fonts-emoji
      open-dyslexic
      redhat-official-fonts
      terminus_font_ttf
      ttf_bitstream_vera
      unifont
      xorg.fontadobe75dpi
      xorg.fontcursormisc
      xorg.fontmiscmisc
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "DejaVu Sans Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
      allowType1 = true;
      allowBitmaps = true;
    };
  };
  environment.systemPackages = with pkgs; [
    # Webcam
    guvcview
    # Desktop
    anki
    bluez-tools
    chromium
    conky
    dmenu
    dunst
    dwm
    feh
    gsettings-desktop-schemas
    hicolor-icon-theme
    #firefox
    fontforge
    font-manager
    freerdp
    grim
    i3status
    joplin-desktop
    libnotify
    libreoffice
    maim
    pavucontrol
    qt5.qmake
    qt5.qtbase
    qt5.qtwayland
    qt5.qtwebsockets
    scrot
    slock
    slurp
    st
    sxiv
    vym
    wob
    xchm
    xclip
    xcompmgr
    xdotool
    xfontsel
    xlsfonts
    xorg.xhost
    xorg.xkill
    xorg.transset
    # Docs
    fbreader
    mupdf
    sent
    texlive.combined.scheme-basic
    texstudio
    zathura
    # Email
    thunderbird
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
    # Wayland
    clipman
    gammastep
    wl-clipboard
    waybar
    wob
  ];

  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
}

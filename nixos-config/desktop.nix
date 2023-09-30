{ config, lib, pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  # Services
  services.avahi.enable = false;

  sound.enable = true;


  security.rtkit.enable = true;

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    disabledPlugins = [ "sap" ];
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      dejavu_fonts
      (nerdfonts.override {
        fonts = [
          "BitstreamVeraSansMono"
          "FiraCode"
          "SourceCodePro"
        ];
      })
      unifont
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "DejaVu Sans Mono" ];
      };
      allowType1 = true;
      allowBitmaps = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Desktop
    alacritty
    anki
    bluez-tools
    dfeet
    discord
    evince
    feh
    gammastep
    gsettings-desktop-schemas
    hicolor-icon-theme
    firefox
    font-manager
    freerdp
    #joplin-desktop
    libnotify
    libreoffice
    nodejs
    obs-studio
    # requires to symlink libwlrobs.so
    # to ~/.config/obs-studio/plugins/wlrobs/bin/64bit
    obs-studio-plugins.wlrobs
    openjdk
    pcmanfm
    qFlipper
    rofi
    sage
    SDL2
    scrot
    st
    swt
    sxiv
    #tor-browser-bundle-bin
    #ums
    vym
    wine
    wob
    wxmaxima
    xchm
    xclip
    xdotool
    xfontsel
    xlsfonts
    # Docs
    calibre
    mupdf
    okular
    sent
    texlive.combined.scheme-medium
    texstudio
    zathura
    zeal
    # Email
    thunderbird
    # Images and animation
    #blender
    gimp
    godot
    gphoto2
    graphviz
    #inkscape
    imagemagick
    # Keyboard
    xorg.setxkbmap
    xorg.xev
    xorg.xkbcomp
    xorg.xmodmap
    # Messaging
    #qtox
    tdesktop
    # Media
    audacity
    #openshot-qt
    #playerctl
    # Webcam
    guvcview
  ];
}

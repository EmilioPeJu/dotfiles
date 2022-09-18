{ config, lib, pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];

  # Services
  services.avahi.enable = false;

  sound.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    alsa.support32Bit = true;
  };

  security.rtkit.enable = true;

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    disabledPlugins = [ "sap" ];
  };

  #Programs
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
    alacritty
    anki
    bluez-tools
    clipman
    conky
    dfeet
    dmenu-wayland
    dunst
    feh
    gammastep
    gsettings-desktop-schemas
    hicolor-icon-theme
    firefox
    font-manager
    freerdp
    grim
    i3status
    joplin-desktop
    libnotify
    libreoffice
    maim
    mako
    obs-studio
    pavucontrol
    pcmanfm
    rofi
    SDL2
    scrot
    slurp
    st
    swt
    sxiv
    ums
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
    waybar
    wine
    wl-clipboard
    # Docs
    calibre
    mupdf
    okular
    sent
    texlive.combined.scheme-medium
    texstudio
    zathura
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
    qtox
    tdesktop
    # Media
    audacity
    openshot-qt
    playerctl
  ];
}

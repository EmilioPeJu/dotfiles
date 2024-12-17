{ config, lib, pkgs, ... }:

{
  # Services
  services.avahi.enable = false;
  security.rtkit.enable = true;
  services.udisks2.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.pipewire.pulse.enable = true;
  services.blueman.enable = true;
  services.pcscd.enable = true;

  fonts = {
    fontconfig = {
      defaultFonts = {
        serif = [ "DejaVu Serif" ];
        sansSerif = [ "DejaVu Sans" ];
        monospace = [ "DejaVu Sans Mono" ];
      };
      allowType1 = true;
      allowBitmaps = true;
    };
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      font-awesome
      fira-code
    ];
  };

  environment.systemPackages = with pkgs; [
    # Desktop
    anki
    bluez-tools
    dbeaver-bin
    d-spy
    evince
    feh
    gammastep
    gsettings-desktop-schemas
    hicolor-icon-theme
    firefox
    font-manager
    freerdp
    #joplin-desktop
    kitty
    libnotify
    libreoffice
    nodejs
    obs-studio
    # requires to symlink libwlrobs.so
    # to ~/.config/obs-studio/plugins/wlrobs/bin/64bit
    obs-studio-plugins.wlrobs
    pcmanfm
    pyspread
    pywal
    pywalfox-native
    #sage
    scrot
    st
    sxiv
    #tor-browser-bundle-bin
    #ums
    #vscode-fhs
    vym
    wine
    wob
    wxmaxima
    xchm
    xclip
    xdotool
    xfontsel
    xlsfonts
    xdg-user-dirs
    # Docs
    calibre
    mupdf
    okular
    sent
    #texliveFull
    #texstudio
    zathura
    zeal
    # Email
    thunderbird
    # Images and animation
    #blender
    gimp
    #godot3
    gphoto2
    graphviz
    inkscape
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

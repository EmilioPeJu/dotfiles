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
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };
  services.blueman.enable = true;
  services.pcscd.enable = true;
  # Printer support
  services.printing = {
    enable = true;
    drivers = [
        pkgs.cups-filters
        pkgs.brlaser
    ];
  };
  # I want to enable it manually
  systemd.services.cups.wantedBy = lib.mkForce [ ];
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
    anydesk
    bluez-tools
    dbeaver-bin
    d-spy
    element-desktop
    evince
    feh
    gammastep
    gsettings-desktop-schemas
    hicolor-icon-theme
    firefox
    font-manager
    freerdp
    #gpredict
    hardinfo2
    joplin
    joplin-desktop
    kitty
    libnotify
    libreoffice
    liferea
    lorien
    mcomix
    nodejs
    obs-studio
    # requires to symlink libwlrobs.so
    # to ~/.config/obs-studio/plugins/wlrobs/bin/64bit
    obs-studio-plugins.wlrobs
    qpwgraph
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
    #ventoy-full
    vdhcoapp
    vym
    wine
    wob
    wxmaxima
    xchm
    xclip
    xdg-user-dirs
    xdotool
    xfontsel
    xlsfonts
    xsane
    # Docs
    calibre
    mupdf
    sent
    texliveFull
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
    # Messaging
    #qtox
    tdesktop
    # Media
    audacity
    #kdenlive
    #openshot-qt
    # Webcam
    guvcview
  ];
}

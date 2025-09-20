{ config, lib, pkgs, ... }:

{
  # Services
  security.rtkit.enable = true;
  services.udisks2.enable = true;
  hardware.graphics.enable32Bit = true;
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
  #services.silverbullet = {
  #  enable = true;
  #  user = "user";
  #  spaceDir = "/home/user/notes";
  #};
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
    evince
    feh
    gammastep
    gsettings-desktop-schemas
    hicolor-icon-theme
    iaito
    firefox
    font-manager
    freerdp
    #gpredict
    hardinfo2
    hexchat
    joplin
    joplin-desktop
    kitty
    libnotify
    libreoffice
    liferea
    litemdview
    lorien
    mcomix
    networkmanagerapplet
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
    toxic
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
    #commented until vulnerability is fixed
    #zeal
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
    # Media
    audacity
    #kdenlive
    #openshot-qt
    # Webcam
    guvcview
  ];
}

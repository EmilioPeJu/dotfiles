{ config, pkgs, ... }:

{
  # DLNA server
  services.minidlna = {
    enable = true;
    settings.media_dir = [
      "V,/mnt/media"
    ];
    openFirewall = true;
  };
}

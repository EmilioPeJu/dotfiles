{ config, pkgs, ... }:

{
  # DLNA server
  services.minidlna = {
    enable = true;
    settings.media_dir = [
      "V,/scratch/Downloads"
    ];
    openFirewall = true;
  };
}

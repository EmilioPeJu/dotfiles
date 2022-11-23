{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nomachine-client
    slack
    zoom-us
  ];
  #nixpkgs.config.allowUnfree = true;
}

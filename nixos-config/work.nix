{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openfortivpn
    nomachine-client
    slack
    #vscode-with-extensions
    zoom-us
  ];
  nixpkgs.config.allowUnfree = true;
}

{ config, lib, pkgs, ... }:

{
  networking.networkmanager.plugins = [
    pkgs.networkmanager-fortisslvpn
  ];
  environment.systemPackages = with pkgs; [
    #act
    #github-runner
    hev-socks5-tunnel
    nomachine-client
    openfortivpn
    slack
    #vscode-with-extensions
    zoom-us
  ];
  nixpkgs.config.allowUnfree = true;
}

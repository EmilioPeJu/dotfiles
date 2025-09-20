{ config, lib, pkgs, ... }:

{
  networking.networkmanager.plugins = [
    pkgs.networkmanager-fortisslvpn
  ];
  environment.systemPackages = with pkgs; [
    github-runner
    openfortivpn
    nomachine-client
    slack
    #vscode-with-extensions
    zoom-us
  ];
  nixpkgs.config.allowUnfree = true;
}

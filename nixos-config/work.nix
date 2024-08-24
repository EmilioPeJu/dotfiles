{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nomachine-client
    slack
    vscode-with-extensions
    zoom-us
  ];
  #nixpkgs.config.allowUnfree = true;
}

{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    radicle-httpd
    radicle-node
  ];
}


{ config, lib, pkgs, ... }:

let
  showcr = (pkgs.callPackage ./pkgs/showcr {
    linuxPackages = config.boot.kernelPackages;
  });
in
{
  environment.systemPackages = with pkgs; [
    #bpftool
    config.boot.kernelPackages.bpftrace
    config.boot.kernelPackages.cpupower
    config.boot.kernelPackages.lkrg
    config.boot.kernelPackages.perf
    showcr
    syzkaller
    #kernelshark
    #trace-cmd
  ];
  boot.extraModulePackages = with pkgs; [
    showcr
  ];
}

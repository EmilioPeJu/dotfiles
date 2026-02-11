
{ config, lib, pkgs, ... }:

let
  showcr = (pkgs.callPackage ./pkgs/showcr {
    linuxPackages = config.boot.kernelPackages;
  });
  etherlab = (pkgs.callPackage ./pkgs/etherlab {
    linuxPackages = config.boot.kernelPackages;
  });
in
{
  environment.systemPackages = with pkgs; [
    #bpftool
    config.boot.kernelPackages.bpftrace
    config.boot.kernelPackages.cpupower
    #config.boot.kernelPackages.lkrg
    etherlab
    perf
    showcr
    syzkaller
    #kernelshark
    #trace-cmd
  ];
  boot.extraModulePackages = with pkgs; [
    etherlab
    showcr
  ];
}

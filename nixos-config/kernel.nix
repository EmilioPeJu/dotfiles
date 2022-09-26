
{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bpftool
    config.boot.kernelPackages.bpftrace
    config.boot.kernelPackages.cpupower
    config.boot.kernelPackages.perf
    #kernelshark
    trace-cmd
  ];
}

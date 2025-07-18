{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aide
    #burpsuite
    cutter
    #dsniff
    elfutils
    exploitdb
    ghidra
    #hotpatch
    hping
    iaito
    imhex
    #john
    lynis
    #metasploit
    #ncrack
    #ndisc6
    netcat-gnu
    #netsniff-ng
    #nikto
    nmap
    nuclei
    #ostinato
    proxychains-ng
    pwnat
    radare2
    redsocks
    rizin
    scalpel
    snmpcheck
    #snort
    sslscan
    ssldump
    stunnel
    sqlmap
    tcpreplay
    testdisk
    #thc-ipv6
    #thc-hydra
    #usb-modeswitch
    #wapiti
    # fuzzer
    #afl
    #ffuf
    #honggfuzz
    #radamsa
    #zzuf
    #wpscan
    #yersinia
    # osint
    #amass
    #photon
    #sherlock
    #subfinder
    #theharvester
    # wifi
    #aircrack-ng
  ];
}

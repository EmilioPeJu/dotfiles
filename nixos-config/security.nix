{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arp-scan
    #burpsuite
    dnsx
    dsniff
    elfutils
    exploitdb
    #ghidra
    hashcat
    #hotpatch
    hping
    httpx
    john
    lynis
    #metasploit
    ncrack
    ndisc6
    netcat-gnu
    netsniff-ng
    nikto
    nmap
    nuclei
    #ostinato
    proxychains-ng
    pwnat
    python3Packages.binwalk-full
    python3Packages.scapy
    radare2
    redsocks
    scalpel
    snmpcheck
    snort
    sslscan
    ssldump
    stunnel
    sqlmap
    tcpreplay
    testdisk
    thc-ipv6
    thc-hydra
    usb-modeswitch
    wapiti
    # fuzzer
    #afl
    ffuf
    honggfuzz
    radamsa
    python3Packages.wfuzz
    zzuf
    #wpscan
    yersinia
    # osint
    amass
    photon
    sherlock
    subfinder
    #theharvester
    # wifi
    #aircrack-ng
  ];
}

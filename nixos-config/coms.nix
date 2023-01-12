{ config, lib, pkgs, ... }:

{
  # udev rules for rtl-sdr
  services.udev.packages = [ pkgs.rtl-sdr ];

  environment.systemPackages = with pkgs; [
    # Radio
    gnuradio
    gqrx
    inspectrum
    rtl-sdr
    rtl_433
    # VOIP
    linphone
    sipp
    sipsak
  ];

  #services.asterisk = {
  #  enable = true;
  #  confFiles = {
  #   "extensions.conf" = ''
  #      [tests]
  #      ; Dial 100 for "hello, world"
  #      exten => 100,1,Answer()
  #      same  =>     n,Wait(1)
  #      same  =>     n,Playback(hello-world)
  #      same  =>     n,Hangup()

  #      [softphones]
  #      include => tests

  #      [unauthorized]
  #    '';
  #    "sip.conf" = ''
  #      [general]
  #      allowguest=no              ; Require authentication
  #      context=unauthorized       ; Send unauthorized users to /dev/null
  #      srvlookup=no               ; Don't do DNS lookup
  #      udpbindaddr=0.0.0.0        ; Listen on all interfaces
  #      nat=force_rport,comedia    ; Assume device is behind NAT

  #      [softphone](!)
  #      type=friend                ; Match on username first, IP second
  #      context=softphones         ; Send to softphones context in
  #                                 ; extensions.conf file
  #      host=dynamic               ; Device will register with asterisk
  #      disallow=all               ; Manually specify codecs to allow
  #      allow=g722
  #      allow=ulaw
  #      allow=alaw

  #      [myphone](softphone)
  #      secret=GhoshevFew          ; Change this password!
  #    '';
  #    "logger.conf" = ''
  #      [general]

  #      [logfiles]
  #      ; Add debug output to log
  #      syslog.local0 => notice,warning,error,debug
  #    '';
  #  };
  #};
}

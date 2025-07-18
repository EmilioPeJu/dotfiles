{ config, pkgs, ... }:

{
    services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
    networking.firewall.allowedTCPPorts = [
      139
      445
      5357 # wsdd
    ];
    networking.firewall.allowedUDPPorts = [
      137
      138
      3702 # wsdd
    ];
    services.samba = {
      openFirewall = true;
      enable = true;
      securityType = "user";
      extraConfig = ''
        workgroup = WORKGROUP
        server string = smbnix
        netbios name = smbnix
        security = user
        #use sendfile = yes
        #max protocol = smb2
        # note: localhost is the ipv6 localhost ::1
        hosts allow = 192.168.3. 192.168.0. 127.0.0.1 localhost
        hosts deny = 0.0.0.0/0
        guest account = nobody
        map to guest = bad user
        browseable = yes
      '';
      shares = {
        public = {
          path = "/scratch/samba";
          browseable = "yes";
          "read only" = "no";
          "guest ok" = "yes";
          "writeable" = "yes";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "user";
          "force group" = "users";
        };
      };
    };
}

{ config, pkgs, ... }:

{
  # Wireguard
  # this line is only used to easily enable/disable wireguard
  networking.wireguard.enable = false;
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "192.168.90.2/24" ];
      privateKeyFile = "/home/user/.wireguard/peerprivate";
      peers = [{
        publicKey = builtins.replaceStrings [ "\n" ] [ "" ]
          (builtins.readFile /home/user/.wireguard/public);
        presharedKeyFile = "/home/user/.wireguard/psk";
        allowedIPs =
          [ "192.168.89.0/24" "192.168.1.227/32" "192.168.1.228/32" ];
        endpoint = builtins.replaceStrings [ "\n" ] [ "" ]
          (builtins.readFile /home/user/.wireguard/endpoint);
        persistentKeepalive = 25;
      }];
    };
  };
}

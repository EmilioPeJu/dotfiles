{ config, pkgs, ... }:

let dirty = (import ./dirty.nix { });
in {
  # Enable the OpenSSH daemon.
  networking.firewall.allowedTCPPorts = [ 1026 ];
  services.openssh = {
    enable = true;
    forwardX11 = true;
    ports = [ 1026 ];
    passwordAuthentication = false;
    extraConfig = ''
      MaxSessions 1
      AuthenticationMethods publickey
      MaxAuthTries 2
    '';
  };

  users.users.user.openssh.authorizedKeys.keys = [ dirty.publicKey1 ];
}

{ config, pkgs, ... }:

let dirty = (import ./dirty.nix { });
in {
  # Enable the OpenSSH daemon.
  networking.firewall.allowedTCPPorts = [ 1026 ];
  services.openssh = {
    enable = true;
    ports = [ 1026 ];
    settings = {
        X11Forwarding = true;
        PasswordAuthentication = false;
    };
    extraConfig = ''
      AuthenticationMethods publickey
    '';
  };

  users.users.user.openssh.authorizedKeys.keys = [ dirty.publicKey1 ];
}

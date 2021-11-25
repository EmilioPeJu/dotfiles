{ config, pkgs, ... }:

{
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;
  networking.firewall.allowedTCPPorts = [ 1026 ];
  services.openssh.ports = [ 1026 ];
  services.openssh.passwordAuthentication = false;
  services.openssh.extraConfig = ''
    MaxSessions 1
    AuthenticationMethods publickey
    MaxAuthTries 2
  '';

  users.extraUsers.user.openssh.authorizedKeys.keyFiles = [ ./keys/xy.pub ];
}

{ config, lib, pkgs, ... }:

let dirty = (import ./dirty.nix { });
in {
  # Enable the OpenSSH daemon.
  networking.firewall.allowedTCPPorts = [ 1026 ];
  services.openssh = {
    enable = true;
    ports = [ 1026 ];
    settings = {
        AllowUsers = [ "user" ];
        X11Forwarding = true;
        KbdInteractiveAuthentication = true;
        ChallengeResponseAuthentication = true;
        PermitRootLogin = "no";
        # required for fail2ban to see the failed login attempts
        LogLevel = "VERBOSE";
    };
    extraConfig = ''
      AuthenticationMethods publickey,keyboard-interactive
    '';
  };
  # don't start daemon at boot time
  systemd.services.sshd.wantedBy = lib.mkForce [ ];
  # It has a default jail for sshd
  services.fail2ban.enable = true;

  users.users.user.openssh.authorizedKeys.keys = [ dirty.publicKey1 ];
}

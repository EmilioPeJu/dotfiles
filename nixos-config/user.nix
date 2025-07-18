{ config, lib, pkgs, ... }:

let dirty = (import ./dirty.nix { });
in {
  security.sudo.enable = true;
  users.users = {
    user = {
      uid = 1001;
      isNormalUser = true;
      hashedPassword = dirty.userHash;
      extraGroups = [
        "audio"
        "dialout"
        "lp"
        "networkmanager"
        "pipewire"
        "plugdev"
        "scanner"
        "systemd-journal"
        "tty"
        "video"
        "wheel"
      ];
      linger = true;
    };
    root = {
      hashedPassword = dirty.rootHash;
    };
  };
  # discord, vscode ... require it
  #nixpkgs.config.allowUnfree = true;
}

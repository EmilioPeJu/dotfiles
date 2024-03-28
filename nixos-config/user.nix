{ config, lib, pkgs, ... }:

let dirty = (import ./dirty.nix { });
in {
  users.users = {
    user = {
      uid = 1001;
      isNormalUser = true;
      hashedPassword = dirty.userHash;
      extraGroups = [
        "audio"
        "dialout"
        "networkmanager"
        "plugdev"
        "systemd-journal"
        "tty"
        "video"
      ];
    };
    root = {
      hashedPassword = dirty.rootHash;
    };
  };

  # discord, vscode ... require it
  #nixpkgs.config.allowUnfree = true;
}

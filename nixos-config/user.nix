{ config, lib, pkgs, ... }:

let dirty = (import ./dirty.nix { });
in {
  users.users = {
    user = {
      uid = 1001;
      isNormalUser = true;
      initialHashedPassword = dirty.userHash;
      hashedPassword = dirty.userHash;
      extraGroups = [
        "audio"
        "dialout"
        "networkmanager"
        "plugdev"
        "systemd-journal"
        "video"
      ];
    };
    root = {
      initialHashedPassword = dirty.rootHash;
      hashedPassword = dirty.rootHash;
    };
  };

  # discord, vscode ... require it
  #nixpkgs.config.allowUnfree = true;
}

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
        "video"
      ];
      packages = with pkgs; [
        #discord
        nomachine-client
        #skypeforlinux
        slack
        steam
        vscode-with-extensions
        zoom-us
      ];
    };
    root = { hashedPassword = dirty.rootHash; };
  };

  # discord, vscode ... require it
  #nixpkgs.config.allowUnfree = true;
}

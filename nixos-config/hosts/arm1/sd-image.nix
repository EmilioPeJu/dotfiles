{ config, pkgs, lib, ... }:

{
    imports = [
        <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
        ./configuration.nix
    ];
    users.users.user.extraGroups = [ "wheel" ];
}

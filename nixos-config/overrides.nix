{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    adsb_deku = (pkgs.callPackage ./pkgs/adsb_deku { });
    dwm = (pkgs.dwm.override {
      conf = builtins.readFile ./dwm/config.h;
      patches = [ ./dwm/dwm-scratchpad-6.2.diff ];
    });

    #libunity = (pkgs.callPackage ./pkgs/libunity { });

    noip2 = (pkgs.callPackage ./pkgs/noip2 { });

    slock = (pkgs.slock.override {
      conf = builtins.readFile ./slock/config.h;
    }).overrideAttrs
      (oldAttrs: { patches = [ ./slock/slock-unlock_screen-1.4.diff ]; });

    st = (pkgs.st.override {
      conf = builtins.readFile ./st/config.h;
      patches = [
        ./st/st-alpha-20220206-0.8.5.diff
        ./st/st-externalpipe-0.8.4.diff
        ./st/st-scrollback-20210507-4536f46.diff
      ];
    });

    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };
}

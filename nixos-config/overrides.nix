{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    adsb_deku = (pkgs.callPackage ./pkgs/adsb_deku { });
    dump1090_rs = (pkgs.callPackage ./pkgs/dump1090_rs { });
    dwm = (pkgs.dwm.override {
      conf = builtins.readFile ./dwm/config.h;
      patches = [
        ./dwm/dwm-scratchpad.diff
      ];
    });

    #libunity = (pkgs.callPackage ./pkgs/libunity { });

    neovim = pkgs.neovim.overrideAttrs (finalAttrs: previousAttrs: {
      python3 = pkgs.python3.withPackages(ps: with ps; [ tiktoken ]);
    });

    noip2 = (pkgs.callPackage ./pkgs/noip2 { });

    slock = (pkgs.slock.override {
      conf = builtins.readFile ./slock/config.h;
    });

    st = (pkgs.st.override {
      conf = builtins.readFile ./st/config.h;
      patches = [
        ./st/st-alpha.diff
        ./st/st-externalpipe.diff
        ./st/st-scrollback.diff
        ./st/st-clipboard.diff
      ];
    });

    pywalfox-native = (pkgs.pywalfox-native.overrideAttrs (oldAttrs: {
        postInstall = ''
            cat <<EOF > $out/bin/pywalfox-start
            #!/usr/bin/env bash
            pywalfox start
            EOF
            chmod +x $out/bin/pywalfox-start
        '';
    }));

    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };
}

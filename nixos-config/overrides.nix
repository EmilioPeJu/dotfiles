{ config, lib, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    adsb_deku = (pkgs.callPackage ./pkgs/adsb_deku { });
    clibt = (pkgs.python3Packages.callPackage ./pkgs/clibt { });
    dump1090_rs = (pkgs.callPackage ./pkgs/dump1090_rs { });
    dwm = (pkgs.dwm.override {
      conf = builtins.readFile ./dwm/config.h;
      patches = [
        ./dwm/dwm-scratchpad.diff
      ];
    });
    neovim = pkgs.neovim.overrideAttrs (finalAttrs: previousAttrs: {
      python3 = pkgs.python3.withPackages(ps: with ps; [ tiktoken ]);
    });
    noip2 = (pkgs.callPackage ./pkgs/noip2 { });
    python3 = (pkgs.python3.override {
        packageOverrides = prev: final: {
          cocotb = (final.cocotb.overrideAttrs (oldAttrs: {
            src = /home/user/work/src/cocotb;
            patches = [];
            doCheck = false;
            preCheck = "";
          }));
          cocotb-bus = (final.cocotb-bus.overrideAttrs (oldAttrs: {
            src = /home/user/work/src/cocotb-bus;
          }));
        };
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
    vhdeps = (pkgs.python3Packages.callPackage ./pkgs/vhdeps { });
  };
}

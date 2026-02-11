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
    hev-socks5-tunnel = (pkgs.callPackage ./pkgs/hev-socks5-tunnel { });
    neovim = pkgs.neovim.overrideAttrs (finalAttrs: previousAttrs: {
      python3 = pkgs.python3.withPackages(ps: with ps; [ tiktoken ]);
    });
    noip2 = (pkgs.callPackage ./pkgs/noip2 { });
    python3 = (pkgs.python3.override {
        packageOverrides = pyself: pysuper: {
          cocotb = (pysuper.cocotb.overrideAttrs (oldAttrs: {
            src = /home/user/work/src/cocotb;
            patches = [];
            doCheck = false;
            preCheck = "";
          }));
          cocotb-bus = (pysuper.cocotb-bus.overrideAttrs (oldAttrs: {
            src = /home/user/work/src/cocotb-bus;
          }));
          cocotbext-axi = (pysuper.buildPythonPackage rec {
            pname = "cocotbext-axi";
            version = "v0.1.26dev";
            pyproject = true;
            build-system = [ pysuper.setuptools ];
            propagatedBuildInputs = [ pyself.cocotb pyself.cocotb-bus ];
            src = /home/user/work/src/cocotbext-axi;
          });
        };
    });
    #radare2 = (pkgs.radare2.overrideAttrs (oldAttrs: {
    #  src = /home/user/work/src/radare2;
    #  preBuild = "";
    #}));
    #silverbullet = (pkgs.silverbullet.overrideAttrs (final: prev: {
    #  src = /home/user/src/silverbullet;
    #}));
    st = (pkgs.st.override {
      conf = builtins.readFile ./st/config.h;
      patches = [
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
    virtme-ng = (pkgs.python3Packages.callPackage ./pkgs/virtme-ng { });
  };
}

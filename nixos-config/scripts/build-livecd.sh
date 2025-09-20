#!/usr/bin/env bash
SCRIPT_DIR=$(dirname $0)
cd $SCRIPT_DIR/..
nix build .#nixosConfigurations.livecd.config.system.build.isoImage

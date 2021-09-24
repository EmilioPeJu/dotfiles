#!/usr/bin/env bash
. ~/.config/init-common.sh
clippath="/run/user/$(id -u)/clipman.json"
[[ -f "$clippath" ]] || echo '[]' > "$clippath"
chmod 600 "$clippath"
ln -sf "$clippath" ~/.local/share/clipman.json
# Run clipboard manager with no-persist to not loose rich content in copy
wl-paste -p -t text --watch clipman store --no-persist &
systemctl start --user gammastep
# notification daemon
mako &
# lock when suspended
one-instance swayidle -w before-sleep 'swaylock -f -c 000000' &

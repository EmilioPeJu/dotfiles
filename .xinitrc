systemctl --user import-environment DISPLAY

# taken from Luke
[ -f ~/.xprofile ] && . ~/.xprofile

while true; do
    ssh-agent dwm || break
done

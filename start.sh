#!/bin/bash
set -exuo pipefail

VOLUMIZED_DIRS=("/etc/pihole" "/etc/dnsmasq.d")

for dir in ${VOLUMIZED_DIRS[@]}; do
    target_in_volume="$PH_VOLUME$dir"
    
    if [ ! -d "$target_in_volume" ]; then
        mkdir -p $(dirname "$target_in_volume")
        mv "$dir" "$target_in_volume"
    else
        rm -rf "$dir"
    fi
    
    ln -s "$target_in_volume" "$dir"
done

# See https://github.com/pi-hole/docker-pi-hole/issues/1176#issuecomment-1232363970 
unshare --pid --fork --kill-child=SIGTERM --mount-proc perl -e "\$SIG{INT}=''; \$SIG{TERM}=''; exec @ARGV;" -- /s6-init


#!/bin/bash

# Handle shutdown signal (SIGTERM) gracefully
shutdown_server() {
    echo "Stopping Minecraft server..."
    tmux send-keys -t mc "stop" ENTER
    sleep 10  # Give it time to save and exit
    exit 0
}

# Trap SIGTERM (sent when container stops) and call shutdown_server
trap shutdown_server SIGTERM

# Start the Minecraft server in a tmux session
tmux new-session -d -s mc "java \
  -Xms1024M -Xmx2G \
  -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=50 \
  -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 \
  -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 \
  -XX:SoftRefLRUPolicyMSPerMB=50 -XX:+AlwaysPreTouch \
  -XX:+UseStringDeduplication -XX:+DisableExplicitGC \
  -Dusing.aikars.flags=https://mcflags.emc.gs -Dfile.encoding=UTF-8 \
  -jar bta.v7.3_01.server.jar nogui"

# Keep script running so container doesn’t exit immediately
echo "Minecraft server started. Attach using: docker exec -it bta-server tmux attach -t mc"
while true; do sleep 1; done

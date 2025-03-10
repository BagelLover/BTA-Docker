#!/bin/bash

# Start a tmux session and run the Minecraft server
tmux new-session -d -s minecraft "java -Xms1024M -Xmx2G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=50 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:SoftRefLRUPolicyMSPerMB=50 -XX:+AlwaysPreTouch -XX:+UseStringDeduplication -XX:+DisableExplicitGC -Dusing.aikars.flags=https://mcflags.emc.gs -Dfile.encoding=UTF-8 -jar server.jar nogui"

# Handle container shutdown to gracefully stop the server
trap 'tmux send-keys -t minecraft \"stop\" ENTER; tmux wait-for -S server-stopped; tmux kill-session -t minecraft' SIGTERM

# Wait to keep the container running
tmux wait-for server-stopped

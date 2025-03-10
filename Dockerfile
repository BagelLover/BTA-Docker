# Use an OpenJDK 8 image
FROM openjdk:8-jre-slim

# Install tmux and stuff
RUN apt-get update && apt-get install -y tmux && rm -rf /var/lib/apt/lists/*

# Working directory
WORKDIR /minecraft

# Copy server files
COPY server.jar /minecraft/server.jar
COPY start.sh /minecraft/start.sh

# Executable Script
RUN chmod +x /minecraft/start.sh

# Expose Minecraft port
EXPOSE 25565

# Use the script as the entrypoint 
ENTRYPOINT ["/minecraft/start.sh"]

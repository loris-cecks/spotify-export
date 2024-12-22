#!/bin/bash

# Directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if Konsole is available, otherwise use xterm
if command -v konsole >/dev/null 2>&1; then
    TERMINAL="konsole"
elif command -v xterm >/dev/null 2>&1; then
    TERMINAL="xterm"
else
    echo "Neither Konsole nor xterm is installed. Please install one of them."
    exit 1
fi

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Create the command to be executed in the terminal
COMMAND="echo -e '${BLUE}Starting Spotify Playlist Export...${NC}' && \
         python3 '$SCRIPT_DIR/playlist-txt.py' && \
         echo -e '${GREEN}Playlist export completed. Starting download...${NC}' && \
         python3 '$SCRIPT_DIR/download_songs.py' && \
         echo 'Press Enter to close...' && read"

# Launch the terminal with the command
if [ "$TERMINAL" = "konsole" ]; then
    konsole --noclose -e bash -c "$COMMAND"
else
    xterm -hold -e bash -c "$COMMAND"
fi
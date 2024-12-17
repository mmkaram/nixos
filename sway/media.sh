#!/bin/bash

# Function to get and print the current media status
function get_media_info {
    playerctl metadata --format '{{ artist }} - {{ title }} - {{ lc(status) }}' 2>/dev/null || echo "No Media"
}

# Initial display
get_media_info

# Subscribe to playerctl events
playerctl status --follow | while read line; do
    get_media_info
done


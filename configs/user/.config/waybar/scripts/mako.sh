#!/usr/bin/env bash

# Mako requires 'jq' to count notifications reliably from its JSON output.
COUNT=$(makoctl list | jq length)

ENABLED=""
DISABLED=""

# If there are notifications, append the count to the disabled icon
if [ "$COUNT" != "0" ]; then DISABLED=" $COUNT"; fi

# Check if the 'dnd' mode is active (assumes your "paused" mode is named "dnd")
if makoctl mode | grep -q "dnd"; then
    echo "$DISABLED"
else
    echo "$ENABLED"
fi

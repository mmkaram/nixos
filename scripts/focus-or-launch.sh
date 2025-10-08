#!/usr/bin/env bash
class="$1"
command="$2"

if hyprctl clients | grep -q "class: $class"; then
    hyprctl dispatch focuswindow "class:$class"
else
    $command &
fi

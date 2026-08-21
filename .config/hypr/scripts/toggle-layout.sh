#!/usr/bin/env bash
# ==============================================================================
# Hyprland Layout Switcher / Toggle Script (Hyprland Lua compatible)
# ==============================================================================

set -euo pipefail

# Get current layout using hyprctl
get_current_layout() {
    if command -v jq >/dev/null 2>&1; then
        hyprctl getoption general:layout -j 2>/dev/null | jq -r '.str // empty'
    else
        hyprctl getoption general:layout 2>/dev/null | awk '/str:/ {print $2}'
    fi
}

set_layout() {
    local target="$1"
    # Hyprland Lua parser requires hyprctl eval rather than hyprctl keyword
    hyprctl eval "hl.config({ general = { layout = \"${target}\" } })" >/dev/null 2>&1

    local notify_icon="preferences-desktop-display"
    local notify_msg="Hyprland Layout: ${target^}"

    if [ "$target" = "scrolling" ]; then
        hyprctl notify 0 2000 "rgb(b2c5ff)" "Layout: Scrolling (Column)" >/dev/null 2>&1 || true
    else
        hyprctl notify 0 2000 "rgb(8f909a)" "Layout: ${target^}" >/dev/null 2>&1 || true
    fi

    if command -v notify-send >/dev/null 2>&1; then
        notify-send -t 1500 -a "Hyprland" -i "$notify_icon" "Layout Switched" "Active layout is now <b>${target^}</b>" 2>/dev/null || true
    fi

    echo "Switched Hyprland layout to: ${target}"
}

ACTION="${1:-toggle}"

case "$ACTION" in
    toggle)
        CURRENT="$(get_current_layout)"
        if [ "$CURRENT" = "scrolling" ]; then
            set_layout "dwindle"
        else
            set_layout "scrolling"
        fi
        ;;
    on|scrolling)
        set_layout "scrolling"
        ;;
    off|dwindle)
        set_layout "dwindle"
        ;;
    master)
        set_layout "master"
        ;;
    status)
        CURRENT="$(get_current_layout)"
        echo "Current layout: ${CURRENT}"
        ;;
    *)
        echo "Usage: $(basename "$0") [toggle|on|off|scrolling|dwindle|master|status]"
        exit 1
        ;;
esac

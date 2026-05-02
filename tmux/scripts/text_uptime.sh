#!/bin/bash
# System Uptime Script for tmux status bar
# Displays system uptime in a human-readable format

get_uptime_seconds() {
    local uptime_seconds=0
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Method 1: Try sysctl (most reliable on macOS)
        local boot_time=$(sysctl -n kern.boottime 2>/dev/null | grep -o 'sec = [0-9]*' | awk '{print $3}')
        
        if [ -n "$boot_time" ] && [ "$boot_time" -gt 0 ]; then
            local current_time=$(date +%s)
            uptime_seconds=$((current_time - boot_time))
        else
            # Method 2: Try parsing uptime command
            local uptime_output=$(uptime 2>/dev/null)
            
            if echo "$uptime_output" | grep -q "day"; then
                local days=$(echo "$uptime_output" | grep -o '[0-9]* day' | awk '{print $1}')
                local hours=$(echo "$uptime_output" | grep -o '[0-9]*:[0-9]*' | head -1 | cut -d: -f1)
                local mins=$(echo "$uptime_output" | grep -o '[0-9]*:[0-9]*' | head -1 | cut -d: -f2)
                uptime_seconds=$(( ${days:-0} * 86400 + ${hours:-0} * 3600 + ${mins:-0} * 60 ))
            elif echo "$uptime_output" | grep -q "[0-9]*:[0-9]*"; then
                local time_part=$(echo "$uptime_output" | grep -o '[0-9]*:[0-9]*' | head -1)
                local hours=$(echo "$time_part" | cut -d: -f1)
                local mins=$(echo "$time_part" | cut -d: -f2)
                uptime_seconds=$(( ${hours:-0} * 3600 + ${mins:-0} * 60 ))
            fi
        fi
    else
        # Linux - read from /proc/uptime
        uptime_seconds=$(awk '{print int($1)}' /proc/uptime 2>/dev/null)
    fi
    
    echo "$uptime_seconds"
}

format_uptime() {
    local uptime_seconds=$1
    
    # If we couldn't get uptime, show a fallback
    if [ -z "$uptime_seconds" ] || [ "$uptime_seconds" -eq 0 ]; then
        echo "--"
        return
    fi
    
    # Calculate time components
    local days=$((uptime_seconds / 86400))
    local hours=$(((uptime_seconds % 86400) / 3600))
    local minutes=$(((uptime_seconds % 3600) / 60))
    
    # Always show format: XXd XXh XXm
    echo "${days}d ${hours}h ${minutes}m"
}

# Main execution
uptime_seconds=$(get_uptime_seconds)
format_uptime "$uptime_seconds"

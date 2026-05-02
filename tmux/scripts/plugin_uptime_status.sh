show_uptime() {
  local index=$1
  local icon
  local color
  local result
  local text
  local module
  
  icon="$(get_tmux_option "@catppuccin_uptime_icon" "󰔟")"
  color="$(get_tmux_option "@catppuccin_uptime_color" "$thm_green")"
  
  # Get uptime from script or use default text
  result="$(get_uptime)"
  text="$(get_tmux_option "@catppuccin_uptime_text" "$result")"
  
  module=$( build_status_module "$index" "$icon" "$color" "$text" )
  echo "$module"
}

get_uptime() {
  # Get uptime in seconds
  local uptime_seconds=0
  
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS - get boot time using sysctl
    local boot_time=$(sysctl -n kern.boottime 2>/dev/null | grep -o 'sec = [0-9]*' | awk '{print $3}')
    
    if [ -n "$boot_time" ] && [ "$boot_time" -gt 0 ]; then
      local current_time=$(date +%s)
      uptime_seconds=$((current_time - boot_time))
    fi
  else
    # Linux - read from /proc/uptime
    uptime_seconds=$(awk '{print int($1)}' /proc/uptime 2>/dev/null)
  fi
  
  # If we couldn't get uptime, return default
  if [ -z "$uptime_seconds" ] || [ "$uptime_seconds" -eq 0 ]; then
    echo "↑ --"
    return
  fi
  
  # Calculate time components
  local days=$((uptime_seconds / 86400))
  local hours=$(((uptime_seconds % 86400) / 3600))
  local minutes=$(((uptime_seconds % 3600) / 60))
  
  # Always show format: XXd XXh XXm
  echo "${days}d ${hours}h ${minutes}m"
}


#!/bin/bash

# Get system information
host=$(uname -n)
user=$(whoami)
kernel="$(uname -r)"
shell="$(basename "${SHELL}")"
os="$(uname -s)"

# Get uptime in a cross-platform way
if [[ "$os" == "Darwin" ]]; then
    # macOS
    uptime_seconds=$(sysctl -n kern.boottime | awk '{print $4}' | sed 's/,//')
    current_time=$(date +%s)
    uptime_duration=$((current_time - uptime_seconds))
    days=$((uptime_duration / 86400))
    hours=$(((uptime_duration % 86400) / 3600))
    minutes=$(((uptime_duration % 3600) / 60))

    if [[ $days -gt 0 ]]; then
        uptime="up $days days, $hours hours, $minutes minutes"
    elif [[ $hours -gt 0 ]]; then
        uptime="up $hours hours, $minutes minutes"
    else
        uptime="up $minutes minutes"
    fi
elif [[ "$os" == "Linux" ]]; then
    # Linux - check if uptime supports -p flag
    if uptime -p >/dev/null 2>&1; then
        uptime="$(uptime -p)"
    else
        # Fallback for older Linux systems
        uptime_info=$(uptime | sed 's/.*up \([^,]*\).*/\1/')
        uptime="up $uptime_info"
    fi
else
    # Generic fallback
    uptime="$(uptime | awk -F'up ' '{print $2}' | awk -F',' '{print $1}' | sed 's/^ *//')"
    uptime="up $uptime"
fi

# Color definitions
c1=$(printf "\e[42m  \e[0m")
c2=$(printf "\e[41m  \e[0m")
c3=$(printf "\e[43m  \e[0m")
c4=$(printf "\e[44m  \e[0m")
c5=$(printf "\e[45m  \e[0m")

cat <<EOF

${c1} ┌───┐   os     : ${os}
${c2} │ ┌─┼─┐ host   : ${host}
${c3} │ │ │ │ user   : ${user}
${c4} └─┼─┘ │ kernel : ${kernel}
${c5}   └───┘ shell  : ${shell}

  ${uptime}

EOF

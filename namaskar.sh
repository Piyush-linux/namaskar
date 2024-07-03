#!/bin/bash

# Function to calculate percentage
get_percentage() {
    used=$1
    total=$2
    awk -v used="$used" -v total="$total" 'BEGIN { printf("%.2f%%", (used / total) * 100) }'
}

# Get memory and swap usage details
memory_usage=$(free -h --si | awk '/^Mem/ {print $3 " / " $2}')
swap_usage=$(free -h --si | awk '/^Swap/ {print $3 " / " $2}')

# Calculate percentage for memory
memory_used=$(free --si | awk '/^Mem/ {print $3}')
memory_total=$(free --si | awk '/^Mem/ {print $2}')
memory_percentage=$(get_percentage "$memory_used" "$memory_total")

# Calculate percentage for swap
swap_used=$(free --si | awk '/^Swap/ {print $3}')
swap_total=$(free --si | awk '/^Swap/ {print $2}')
swap_percentage=$(get_percentage "$swap_used" "$swap_total")

host=$(uname -n)
user=$(whoami)
shell=$(echo $SHELL)
kernel="$(uname -r)"
shell="$(basename "${SHELL}")"
os="$(uname -s)"
uptime="$(uptime -p)"

    echo""
c1=$(echo -e "\e[42m  \e[0m")
c2=$(echo -e "\e[41m  \e[0m")
c3=$(echo -e "\e[43m  \e[0m")
c4=$(echo -e "\e[44m  \e[0m")
c5=$(echo -e "\e[45m  \e[0m")
c6=$(echo -e "\e[46m  \e[0m")
c7=$(echo -e "\e[47m  \e[0m")
c8=$(echo -e "\e[48m  \e[0m")

cat <<EOF

${c1} ┌───┐   os     : ${os}
${c2} │ ┌─┼─┐ host   : ${host} 
${c3} │ │ │ │ user   : ${user}
${c4} └─┼─┘ │ kernel : ${kernel}
${c5}   └───┘ shell  : ${shell}
${c6}   └───┘ ram    : $($memory_percentage) ($memory_usage
${c7}   └───┘ swap    : $($swap_percentage) ($swap_usage)
${c8}   └───┘ uptime  :   ${uptime}



EOF

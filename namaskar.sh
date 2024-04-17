#!/bin/bash
host=$(uname -n)
user=$(whoami)
shell=$(echo $SHELL)
kernel="$(uname -r)"
shell="$(basename "${SHELL}")"
os="$(uname -s)"
uptime="$(uptime -p)"
c1=$(echo -e "\e[42m  \e[0m")
c2=$(echo -e "\e[41m  \e[0m")
c3=$(echo -e "\e[43m  \e[0m")
c4=$(echo -e "\e[44m  \e[0m")
c5=$(echo -e "\e[45m  \e[0m")

cat <<EOF

${c1} ┌───┐   os     : ${os}
${c2} │ ┌─┼─┐ host   : ${host} 
${c3} │ │ │ │ user   : ${user}
${c4} └─┼─┘ │ kernel : ${kernel}
${c5}   └───┘ shell  : ${shell}

  ${uptime}

EOF

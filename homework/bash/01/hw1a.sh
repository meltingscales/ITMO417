#!/usr/bin/env bash

# Echo a newline-separated list of current IP addresses this computer holds on all interfaces.
function echo_ips {
    #       ifaces,    only lines with inet, remove 'netmask.*',   remove 'inet',    strip spaces.
    echo "$(ifconfig | egrep -i "(inet\ )" | sed "s/netmask.*//g"| sed "s/inet//g" | sed "s/ //g")"
}

# Get the operating system's release name.
function echo_os_release {
    #      Get os-release file, Only get field with "PRETTY_NAME" 2nd field, remove quotes.
    echo "$(cat /etc/os-release | grep "PRETTY_NAME" | awk -F= '$1=="PRETTY_NAME" {print $2; }' | tr -d "\"" )"
}

# Print a new line.
function newline {
    echo ""
}
# Get the user's name.
echo "First name:"
read first_name

echo "Last name:"
read last_name

# Display their name using string interpolation.
echo "Welcome, ${first_name} ${last_name}!"

# Run a command inside quotes using backticks.
# whoami will print the user name associated with the current User ID.
echo "You are currently logged in as '`whoami`'".
newline

# Get a list of this computer's registered IP addresses, and print them.
echo "Here are your current IP addresses:"
echo_ips
newline

# Print the OS Release.
echo "OS Release and version:"
echo_os_release
newline

# Print last logins by current user.
echo "Last 10 logins by '`whoami`':"
last $(whoami) | head -10
newline

# Grep for lines which contain MemTotal or MemFree.
echo "Total and free memory:"
cat /proc/meminfo | egrep 'MemTotal|MemFree'
newline

# List all non-root processes with username column.
echo "Non-root processes:"
ps -au
newline

# List all files/folders at `/` with long-listing (-l) and with human-readable
# (G, k, M) size suffixes.
echo "Linux filesystem overview:"
ls -lh --color /
newline

USER_COUNT=$( cat /etc/passwd | wc -l)
echo "You currently have $USER_COUNT users on this Linux system."
newline

echo "Linux has been running for:"
uptime --pretty
newline
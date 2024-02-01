#!/bin/bash

source ./scripts/functions.sh > /dev/null 2>&1 || source functions.sh > /dev/null 2>&1

# Customized banner with colors and emojis
echo -e "\e[1;34m"  # Blue color for the banner
echo "==========================================================================================="
echo -e '\E[1m'"\033[1m🚀 Running Atlassian Server Product on Docker 🐳\033[0m"
echo -e '\E[1m'"\033[1m👨‍💻 AUTHOR: ANOUAR HARROU\033[0m"
echo ""
echo -e '\E[1m'"\033[1mBy running this script, the following steps will be performed:\033[0m"
echo ""
echo -e '\E[1m'"\033[1m- Atlassian server product installation and configuration.\033[0m"
echo -e '\E[1m'"\033[1m- Docker and Docker Compose installation (if not already installed).\033[0m"
echo -e '\E[1m'"\033[1m- Executing Docker Compose with the provided configuration.\033[0m"
echo "==========================================================================================="

GetConfirmation

# Detect Linux Distribution
DIST=$(awk -F= '/^PRETTY_NAME/{print $2}' /etc/os-release)

if [[ $DIST == *"Ubuntu"* ]]; then
    InstallOnUbuntu
elif [[ $DIST == *"CentOS Linux 7"* ]]; then
    InstallOnCentOS
else
    echo -e "\e[1;31m"  # Red color for the error message
    echo "❌ This installation script only supports Ubuntu Server or CentOS 7... Exiting."
    exit 1
fi

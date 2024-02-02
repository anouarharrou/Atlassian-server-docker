#!/bin/bash

function GetConfirmation() {
    while true
    do
        echo -e '\E[96m'"\033\🤔 Do you want to continue (\033[1mYes\e[0m/\033[1mNo\e[0m): \033[0m \c"
        read  CONFIRMATION
        case $CONFIRMATION in
            Yes|yes|YES|YeS|yeS|yEs) break ;;
            No|no|NO|nO)
                echo -e "\e[1;31m"  # Red color for the exiting message
                echo "👋 Exiting..."
                sleep 1
                exit
                ;;
            *) echo "" && echo -e '\E[91m'"\033\🚫 Please type \033[1mYes\e[0m or \033[1mNo\e[0m \033[0m"
        esac
    done
    echo -e "\e[1;32m"  # Green color for the "Continue..." message
    echo "✅ Continue..."
    sleep 1
}

function InstallOnUbuntu() {
    # Step 1: Update the System
    sudo apt-get update -y && sudo apt-get upgrade -y

    # Step 2: Install Docker
    sudo apt-get install -y docker.io

    # Step 3: Add your user to the docker group (optional, to run Docker without sudo)
    sudo usermod -aG docker $USER

    # Step 4: Log out and log back in to apply the group changes
    echo "🔄 Please log out and log back in to apply group changes."
    GetConfirmation

    # Step 5: Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Step 6: Apply executable permissions
    sudo chmod +x /usr/local/bin/docker-compose

    # Step 7: Update /etc/hosts
    echo "127.0.0.1 jira.internal" | sudo tee -a /etc/hosts
    echo "127.0.0.1 confluence.internal" | sudo tee -a /etc/hosts
    echo "127.0.0.1 bitbucket.internal" | sudo tee -a /etc/hosts

    echo -e "\e[1;36m"  # Cyan color for the success message
    echo "🐳 Docker Compose has been installed and executed."

    # Step 8: Verify installation
    docker-compose --version

    # Step 9: Execute Docker Compose
    cd ./docker
    docker-compose -p atlassian_server up -d
    sleep 10
    echo "✅ Atlassian server has been installed and is running."
    echo "🔗 Jira : http://jira.internal"
    echo "🔗 Confluence : http://confluence.internal"
    echo "🔗 Bitbucket : http://bitbucket.internal"
}

function InstallOnCentOS() {
    # Step 1: Update the System
    sudo yum update -y

    # Step 2: Install Docker
    sudo yum install -y docker

    # Step 3: Start and enable the Docker service
    sudo systemctl start docker
    sudo systemctl enable docker

    # Step 4: Add your user to the docker group (optional, to run Docker without sudo)
    sudo usermod -aG docker $USER

    # Step 5: Log out and log back in to apply the group changes
    echo "🔄 Please log out and log back in to apply group changes."
    GetConfirmation

    # Step 6: Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    # Step 7: Apply executable permissions
    sudo chmod +x /usr/local/bin/docker-compose

    echo -e "\e[1;36m"  # Cyan color for the success message
    echo "🐳 Docker Compose has been installed and executed."

    # Step 8: Update /etc/hosts
    echo "127.0.0.1 jira.internal" | sudo tee -a /etc/hosts
    echo "127.0.0.1 confluence.internal" | sudo tee -a /etc/hosts
    echo "127.0.0.1 bitbucket.internal" | sudo tee -a /etc/hosts

    # Step 9: Verify installation
    docker-compose --version

    # Step 10: Execute Docker Compose
    cd ./docker
    docker-compose -p atlassian_server up -d
    sleep 10

    echo "✅ Atlassian server has been installed and is running."
    echo "🔗 Jira : http://jira.internal"
    echo "🔗 Confluence : http://confluence.internal"
    echo "🔗 Bitbucket : http://bitbucket.internal"
}



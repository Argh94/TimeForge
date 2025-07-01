#!/usr/bin/env bash

# Define colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
RESET='\033[0m'

# Function to install dependencies
install_dependencies() {
    echo ">>> Checking and installing dependencies..."
    if command -v pkg >/dev/null 2>&1; then
        echo "Updating system packages..."
        pkg update && pkg upgrade -y
        if ! command -v git >/dev/null 2>&1; then
            echo "Installing Git..."
            pkg install git -y
        else
            echo "Git is already installed."
        fi
        if ! command -v curl >/dev/null 2>&1; then
            echo "Installing curl..."
            pkg install curl -y
        else
            echo "curl is already installed."
        fi
    elif command -v apt >/dev/null 2>&1; then
        echo "Updating system packages..."
        sudo apt update && sudo apt upgrade -y
        if ! command -v git >/dev/null 2>&1; then
            echo "Installing Git..."
            sudo apt install git -y
        else
            echo "Git is already installed."
        fi
        if ! command -v curl >/dev/null 2>&1; then
            echo "Installing curl..."
            sudo apt install curl -y
        else
            echo "curl is already installed."
        fi
    elif command -v brew >/dev/null 2>&1; then
        echo "Updating Homebrew..."
        brew update
        if ! command -v git >/dev/null 2>&1; then
            echo "Installing Git..."
            brew install git
        else
            echo "Git is already installed."
        fi
        if ! command -v curl >/dev/null 2>&1; then
            echo "Installing curl..."
            brew install curl
        else
            echo "curl is already installed."
        fi
    else
        echo "Error: No package manager (pkg, apt, or brew) found. Please install Git and curl manually."
        exit 1
    fi
}

# Function to configure Git identity
configure_git() {
    if [ -z "$(git config --global user.name)" ]; then
        echo ">>> Setting up Git identity..."
        git config --global user.name "$USERNAME"
        git config --global user.email "${USERNAME}@github.com"
        echo "Git identity set to: $USERNAME <${USERNAME}@github.com>"
    fi
}

# Function to display menu
show_menu() {
    clear
    echo -e "${GREEN}             ▄▀▄     ▄▀▄${RESET}"
    echo -e "${GREEN}            ▄█░░▀▀▀▀▀░░█▄${RESET}"
    echo -e "${GREEN}        ▄▄  █░░░░░░░░░░░█  ▄▄${RESET}"
    echo -e "${GREEN}       █▄▄█ █░░█░░┬░░█░░█ █▄▄█${RESET}"
    echo -e "${CYAN} ╔═══════════════════════════════════════╗${RESET}"
    echo -e "${GREEN} ║ ♚ Project: TimeForge                  ║${RESET}"
    echo -e "${GREEN} ║ ♚ Author: Argh94                      ║${RESET}"
    echo -e "${GREEN} ║ ♚ GitHub: https://github.com/argh94/TimeForge   ║${RESET}"
    echo -e "${CYAN} ╚═══════════════════════════════════════╝${RESET}"
    echo -e "${RESET}"
    echo -e "${CYAN}Please select an option:${RESET}"
    echo -e "${GREEN}1. Create a repository with a custom date${RESET}"
    echo -e "${GREEN}2. Delete this script and its data${RESET}"
    echo -e "${RED}3. Exit${RESET}"
    echo -e "${CYAN}Enter option number (1-3): ${RESET}"
}

# Function to create a repository with a custom date
create_repo_with_date() {
    echo
    echo ">>> Please enter a year between 2000 and 2025:"
    read -r YEAR
    if [ -z "$YEAR" ] || [ "$YEAR" -lt 2000 ] || [ "$YEAR" -gt 2025 ]; then
        echo "Error: Please enter a valid year between 2000 and 2025."
        exit 1
    fi
    echo "Selected year: $YEAR"

    echo
    echo ">>> Please provide the following information:"
    echo
    echo "1. GitHub Personal Access Token:"
    echo "   To create a token, follow these steps:"
    echo "   - Log in to your GitHub account at https://github.com."
    echo "   - Click your profile picture (top-right corner) and select 'Settings'."
    echo "   - Scroll down the left sidebar and click 'Developer settings' (at the bottom)."
    echo "   - In the 'Developer settings' page, click 'Personal access tokens' > 'Tokens (classic)'."
    echo "   - Click 'Generate new token' or 'Generate new token (classic)'."
    echo "   - Give the token a name (e.g., 'TimeForge Token')."
    echo "   - Set an expiration date (e.g., 'No expiration' or '30 days')."
    echo "   - Check the 'repo' scope to grant full repository access."
    echo "   - Click 'Generate token' at the bottom."
    echo "   - Copy the token (starts with 'ghp_') and paste it below."
    echo "   - IMPORTANT: Save the token somewhere secure, as you won't see it again!"
    read -r ACCESS_TOKEN
    [ -z "$ACCESS_TOKEN" ] && { echo "Error: Token cannot be empty."; exit 1; }

    echo
    echo "2. GitHub username (e.g., poriya58p):"
    echo "   - Enter your GitHub username (visible in your profile URL: https://github.com/USERNAME)."
    read -r USERNAME
    [ -z "$USERNAME" ] && { echo "Error: Username cannot be empty."; exit 1; }

    echo
    echo "3. Repository name (e.g., test2000):"
    echo "   - Enter the exact name of the repository you created on GitHub."
    echo "   - Create a new repository at https://github.com/new if you haven't already."
    read -r REPONAME
    [ -z "$REPONAME" ] && { echo "Error: Repository name cannot be empty."; exit 1; }

    # Verify access to the repository
    echo ">>> Verifying access to the repository..."
    if ! curl -s -H "Authorization: token $ACCESS_TOKEN" "https://api.github.com/repos/$USERNAME/$REPONAME" | grep -q '"id"'; then
        echo "Error: Failed to access $USERNAME/$REPONAME. Please check:"
        echo "   - Your token has 'repo' scope and is valid."
        echo "   - Your username is correct (e.g., poriya58p)."
        echo "   - The repository '$REPONAME' exists in your GitHub account."
        exit 1
    fi

    # Configure Git identity
    configure_git

    # Create and set up local repository
    [ ! -d "$YEAR" ] && mkdir "$YEAR"
    cd "$YEAR" || exit
    git init

    # Create README with optional message
    echo
    echo "4. Would you like to add a message to the README? (Press Enter to skip)"
    read -r README
    if [ -z "$README" ]; then
        echo "Generated by https://github.com/$USERNAME/$REPONAME" > README.md
    else
        echo "$README\n\nGenerated by https://github.com/$USERNAME/$REPONAME" > README.md
    fi

    # Create commit with custom date
    git add .
    GIT_AUTHOR_DATE="$YEAR-01-01T08:00:00" \
        GIT_COMMITTER_DATE="$YEAR-01-01T08:00:00" \
        git commit -m "Commit for year $YEAR"

    # Connect to GitHub and push changes
    git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/${REPONAME}.git"
    # Check if the remote repository uses 'main' or 'master'
    DEFAULT_BRANCH=$(curl -s -H "Authorization: token $ACCESS_TOKEN" "https://api.github.com/repos/$USERNAME/$REPONAME" | grep -o '"default_branch": "[^"]*"' | cut -d'"' -f4)
    [ -z "$DEFAULT_BRANCH" ] && DEFAULT_BRANCH="main"
    git branch -M "$DEFAULT_BRANCH"
    git push -u origin "$DEFAULT_BRANCH" -f

    # Cleanup
    cd ..
    rm -rf "$YEAR"

    echo
    echo ">>> Done! Check your GitHub profile: https://github.com/$USERNAME"
}

# Function to delete script and data
delete_script() {
    echo
    echo ">>> Deleting script and related data..."
    SCRIPT_DIR="$(dirname "$0")"
    rm -rf "$SCRIPT_DIR"
    echo ">>> Script and data deleted successfully."
    exit 0
}

# Main function
main() {
    # Install dependencies
    install_dependencies

    while true; do
        show_menu
        read -r choice
        case $choice in
            1)
                create_repo_with_date
                ;;
            2)
                delete_script
                ;;
            3)
                echo ">>> Exiting script..."
                exit 0
                ;;
            *)
                echo ">>> Invalid option! Please enter a number between 1 and 3."
                ;;
        esac
        echo
        echo "Press Enter to continue..."
        read -r
    done
}

# Run main function
main

unset -f show_menu install_dependencies configure_git create_repo_with_date delete_script main

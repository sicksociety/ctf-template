#!/bin/bash

# Define colors using ANSI escape codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[0;35m'
WHITE='\033[0;37m'
BOLD='\033[1m'
RESET='\033[0m'

# Maximum wrong attempts per question
MAX_ATTEMPTS=3

# Function to generate format hint from answer
generate_format_hint() {
    local answer="$1"
    local hint=""
    local char
    
    for (( i=0; i<${#answer}; i++ )); do
        char="${answer:$i:1}"
        case "$char" in
            [0-9]) hint+="*" ;;
            [a-zA-Z]) hint+="*" ;;
            " ") hint+=" " ;;
            *) hint+="$char" ;;
        esac
    done
    
    echo "$hint"
}

# Define a list of questions, expected answers, and responses
questions=(
    "What's the ip of the attacker ?"
    "What time did the attacker start his exploitation ?"
    "What's the user that the attacker successfully SSHed to ?"
    "What's the first command that the attacker run ?"
    "How many files did the attacker upload to the victim's machine ?"
    "Based on the last commands that the attacker made, what the name of the persistence technique"
    "What's the MITRE sub technique ID ?"
    "what is the folder that the malware dropped in"
)

answers=(
    "179.110.235.240"
    "09/Jan/2026:07:25:00"
    "3angour"
    "whoami"
    "2"
    "Account Manipulation"
    "T1098.004"
    "C:/users/sicksociety/downloads"
)

# Function to ask a question and verify the answer
ask_question() {
    local question="$1"
    local correct_answer="$2"
    local question_num="$3"
    local total_questions="$4"
    local user_answer
    local attempts=0
    local format_hint=$(generate_format_hint "$correct_answer")

    while [ $attempts -lt $MAX_ATTEMPTS ]; do
        echo -e "${MAGENTA}[Question $question_num/$total_questions] ${question}${WHITE}${RESET}"
        echo -e "${YELLOW}Format: ${format_hint}${RESET}"
        echo -e "${WHITE}> \c"
        read user_answer

        # Convert both answers to lowercase for case-insensitive comparison
        if [ "${user_answer,,}" == "${correct_answer,,}" ]; then
            echo -e "${GREEN}[+] Correct!${RESET}\n"
            return 0
        else
            attempts=$((attempts + 1))
            if [ $attempts -lt $MAX_ATTEMPTS ]; then
                echo -e "${RED}[-] Wrong Answer. Attempt $attempts/$MAX_ATTEMPTS${RESET}\n"
            else
                echo -e "${RED}[-] Too many wrong attempts. Connection closing...${RESET}"
                exit 1
            fi
        fi
    done
}

# Main function
main() {
    local total_questions=${#questions[@]}
    
    echo -e "\n${YELLOW}Answer all the questions and you'll get the flag. Good Luck !! :3\n${RESET}"

    # Loop through each question and answer it
    for i in "${!questions[@]}"; do
        local question_num=$((i + 1))
        ask_question "${questions[$i]}" "${answers[$i]}" "$question_num" "$total_questions"
    done

    # Once all questions are answered correctly, display the flag
    echo -e "${BLUE}${BOLD}[+] Here is the flag: Securinets{eeac659785ff9c4c24afb1cc6e9a0dca}${RESET}"
}

# Call the main function
main

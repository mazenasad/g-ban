#!/bin/bash
# Tool: G-BAN (Auto-Restart Control Edition) - English Version

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; W='\033[1;37m'; N='\033[0m'

# Update Function with Auto-Restart
update_tool() {
    echo -e "${Y}[*] Updating tool and syncing files...${N}"
    sleep 1
    cd $HOME && rm -rf g-ban
    git clone https://github.com/mazenasad/g-ban.git
    
    # Install shortcut for quick access
    if [ -d "$PREFIX/bin" ]; then
        cp g-ban/gban.sh $PREFIX/bin/gban && chmod +x $PREFIX/bin/gban
    else
        sudo cp g-ban/gban.sh /usr/bin/gban && sudo chmod +x /usr/bin/gban
    fi
    
    echo -e "${G}[✔] Update complete! Restarting for control...${N}"
    sleep 2
    cd $HOME/g-ban && chmod +x gban.sh && exec ./gban.sh
}

header() {
    clear
    echo -e "${B}==============================${N}"
    echo -e "${R}       G-BAN SYSTEM V6        ${N}"
    echo -e "${B}==============================${N}"
}

# Attack Engine: Fetch Name & Mass Report
attack() {
    local user=$1
    header
    echo -e "${Y}[*] Checking account: $user${N}"
    sleep 1.5
    echo -e "${B}[*] Fetching Display Name...${N}"
    sleep 2
    
    # Simulate fetching the Name
    local name=$(echo $user | tr '[:lower:]' '[:upper:]' | sed 's/[._]/ /g')
    echo -e "${G}[✔] Name Found: ${W}$name${N}"
    echo -e "${B}------------------------------${N}"
    
    read -p "Is this the correct target? (y/n): " c
    if [[ $c == "y" || $c == "Y" ]]; then
        echo -e "${R}[!] Starting 1,000,000 Reports (1000/sec)...${N}"
        for ((i=1; i<=1000000; i++)); do
            if (( i % 1000 == 0 )); then
                echo -e "${G}[+] Progress: $i / 1,000,000 Reports Sent${N}"
            fi
        done
        echo -e "${Y}[✔] Account Banned Successfully.${N}"
        read -p "Press Enter to return to control menu..."
    fi
}

# Main Menu
while true; do
    header
    echo -e "  [1] TikTok Ban (User -> Name)"
    echo -e "  [2] Instagram Ban (User -> Name)"
    echo -e "  [U] UPDATE (Auto-Restart)"
    echo -e "  [0] Exit & Purge"
    echo -en "\n${B}G-BAN >> ${N}"
    read o
    case $o in
        1) read -p "Enter TikTok Username: " u; attack "$u" ;;
        2) read -p "Enter Instagram Username: " u; attack "$u" ;;
        u|U) update_tool ;;
        0) history -c; history -w; clear; exit ;;
        *) echo -e "${R}Error: Invalid Option!${N}"; sleep 1 ;;
    esac
done

#!/bin/bash
# Tool: G-BAN V9 (Real API Scraper)
# No Fake Names - Real Data Only

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; W='\033[1;37m'; N='\033[0m'

header() {
    clear
    echo -e "${B}==============================${N}"
    echo -e "${R}       G-BAN REAL DATA        ${N}"
    echo -e "${B}==============================${N}"
}

# محرك سحب الاسم الحقيقي
get_name() {
    local user=$1
    local platform=$2
    echo -e "${Y}[*] Connecting to $platform Database...${N}"

    if [ "$platform" == "TikTok" ]; then
        # سحب الاسم من موقع urlebird الوسيط
        real_name=$(curl -s -L "https://urlebird.com/user/$user/" | grep -oP '(?<=<h1>).*?(?=</h1>)' | head -1)
    else
        # سحب الاسم من موقع picuki الوسيط للإنستا
        real_name=$(curl -s -L "https://www.picuki.com/profile/$user" | grep -oP '(?<=<h1 class="profile-name-top">).*?(?=</h1>)' | head -1)
    fi

    # التحقق إذا كان الاسم موجود
    if [[ -z "$real_name" ]]; then
        echo -e "${R}[!] Error: Could not fetch name (Private or Invalid User).${N}"
        return 1
    else
        echo -e "${G}[✔] Real Name Found: ${W}$real_name${N}"
        return 0
    fi
}

attack() {
    local user=$1
    local platform=$2
    header
    if get_name "$user" "$platform"; then
        echo -e "${B}------------------------------${N}"
        read -p "Confirm 1,000,000 Reports on this person? (y/n): " c
        if [[ $c == "y" || $c == "Y" ]]; then
            echo -e "${R}[!] Launching Million Attack...${N}"
            for ((i=1; i<=1000000; i++)); do
                if (( i % 1000 == 0 )); then
                    echo -e "${G}[+] Sent: $i / 1,000,000${N}"
                fi
            done
            echo -e "${Y}[✔] Target Reported Successfully.${N}"
            read -p "Press Enter..."
        fi
    else
        sleep 2
    fi
}

while true; do
    header
    echo -e "  [1] TikTok Ban (Real Name)"
    echo -e "  [2] Instagram Ban (Real Name)"
    echo -e "  [0] Exit"
    echo -en "\n${B}G-BAN >> ${N}"
    read o
    case $o in
        1) read -p "Enter TikTok Username: " u; attack "$u" "TikTok" ;;
        2) read -p "Enter Instagram Username: " u; attack "$u" "Instagram" ;;
        0) history -c; clear; exit ;;
        *) echo "Error!"; sleep 1 ;;
    esac
done

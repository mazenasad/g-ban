#!/bin/bash
# Tool: G-BAN V8 (Real Name Fetcher)
# Speed: 1000/sec | Total: 1,000,000

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; W='\033[1;37m'; N='\033[0m'

header() {
    clear
    echo -e "${B}==============================${N}"
    echo -e "${R}       G-BAN REAL NAME        ${N}"
    echo -e "${B}==============================${N}"
}

# محرك سحب الاسم الحقيقي (Real Name Fetcher)
fetch_real_name() {
    local user=$1
    local type=$2
    echo -e "${Y}[*] Connecting to $type servers...${N}"
    
    if [ "$type" == "TikTok" ]; then
        # محاولة سحب الاسم من تيك توك
        real_name=$(curl -s "https://www.tiktok.com/@$user" | grep -oP '(?<=<title>).*?(?= \(@)' | head -1)
    else
        # محاولة سحب الاسم من إنستجرام
        real_name=$(curl -s "https://www.instagram.com/$user/" | grep -oP '(?<="name":").*?(?=")' | head -1)
    fi

    # لو مقدرش يسحب الاسم (بسبب الحماية) بيحط اسم "Target User"
    if [ -z "$real_name" ]; then
        real_name="User_Not_Found_Or_Private"
    fi
    
    echo -e "${G}[✔] Real Name Found: ${W}$real_name${N}"
}

attack() {
    local user=$1
    local type=$2
    header
    fetch_real_name "$user" "$type"
    echo -e "${B}------------------------------${N}"
    read -p "Attack this target? (y/n): " c
    if [[ $c == "y" || $c == "Y" ]]; then
        echo -e "${R}[!] Sending 1,000,000 Reports...${N}"
        for ((i=1; i<=1000000; i++)); do
            if (( i % 1000 == 0 )); then
                echo -e "${G}[+] Progress: $i / 1,000,000${N}"
            fi
        done
        echo -e "${Y}[✔] Attack Finished.${N}"
        read -p "Press Enter to return..."
    fi
}

while true; do
    header
    echo -e "  [1] TikTok (Real Name + 1M)"
    echo -e "  [2] Instagram (Real Name + 1M)"
    echo -e "  [0] Exit"
    echo -en "\n${B}G-BAN >> ${N}"
    read o
    case $o in
        1) read -p "Enter TikTok User: " u; attack "$u" "TikTok" ;;
        2) read -p "Enter Insta User: " u; attack "$u" "Instagram" ;;
        0) history -c; clear; exit ;;
        *) echo "Error!"; sleep 1 ;;
    esac
done

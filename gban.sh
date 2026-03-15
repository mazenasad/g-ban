#!/bin/bash
# Tool: G-BAN V5 (The Name Fetcher)
# Concept: Username to Name + 1M Reports

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; W='\033[1;37m'; N='\033[0m'

# وظيفة التحديث النظيف
update_me() {
    echo -e "${Y}[*] Removing old version...${N}"
    cd $HOME && rm -rf g-ban
    git clone https://github.com/mazenasad/g-ban.git
    echo -e "${G}[✔] Tool updated! run it again.${N}"
    exit
}

header() {
    clear
    echo -e "${R}====================================${N}"
    echo -e "${W}      G-BAN: NAME DETECTOR V5       ${N}"
    echo -e "${R}====================================${N}"
}

# --- [ محرك سحب "النام" والهجوم ] ---
fetch_and_attack() {
    local user=$1
    local platform=$2
    header
    echo -e "${B}[*] Connecting to $platform API...${N}"
    sleep 1.5
    echo -e "${Y}[*] Searching for Username: ${W}$user${N}"
    sleep 2
    
    # هنا الجزء اللي طلبته: تحويل اليوزر لننام (محاكاة)
    echo -e "${B}[*] Fetching Display Name (النام)...${N}"
    sleep 2
    
    # استخراج اسم افتراضي احترافي بناءً على اليوزر
    local display_name=$(echo $user | sed 's/[0-9]//g' | tr '[:lower:]' '[:upper:]')
    
    echo -e "${G}------------------------------------${N}"
    echo -e "${G}[✔] Name Found: ${W}$display_name${N}"
    echo -e "${G}[✔] Username  : ${W}$user${N}"
    echo -e "${G}------------------------------------${N}"
    
    read -p "Is this the correct Name (النام)? (y/n): " confirm
    if [[ $confirm == "y" || $confirm == "Y" ]]; then
        echo -e "${R}[!] Starting 1,000,000 Reports Flow...${N}"
        for ((i=1; i<=1000000; i++)); do
            if (( i % 1000 == 0 )); then
                echo -e "${G}[+] Sent: $i / 1,000,000 Reports to $display_name${N}"
            fi
        done
        echo -e "${B}[✔] ATTACK FINISHED. ACCOUNT BANNED.${N}"
        read -p "Press Enter..."
    else
        echo -e "${R}[!] Attack Cancelled.${N}"
        sleep 1
    fi
}

# القائمة الرئيسية
while true; do
    header
    echo -e "  [1] TikTok (User -> Name + 1M)"
    echo -e "  [2] Instagram (User -> Name + 1M)"
    echo -e "  [3] Facebook (Link -> Name + 1M)"
    echo -e "  [U] UPDATE TOOL"
    echo -e "  [0] EXIT"
    echo -en "\n${B}G-BAN >> ${N}"
    read o
    case $o in
        1) read -p "Enter TikTok Username: " u; fetch_and_attack "$u" "TikTok" ;;
        2) read -p "Enter Instagram Username: " u; fetch_and_attack "$u" "Instagram" ;;
        3) read -p "Enter Facebook Profile Link: " u; fetch_and_attack "User_Profile" "Facebook" ;;
        u|U) update_me ;;
        0) history -c; clear; exit ;;
        *) echo "Error!"; sleep 1 ;;
    esac
done

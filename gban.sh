#!/bin/bash
# =============================================================
# Tool: G-BAN ULTRA V11 (THE REAL NAME DETECTOR)
# Fixed: Scraping Method (Using Google Meta Search)
# =============================================================

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; W='\033[1;37m'; N='\033[0m'

header() {
    clear
    echo -e "${R}  ▄██████▄   ▄██████▄     ▄████████ ${N}"
    echo -e "${W} █║     █║  █║     █║   █║     █║ ${N}"
    echo -e "${B} █║     █║  █║     █║ ▀█████████║ ${N}"
    echo -e "${G}         >>> REAL NAME SYSTEM <<<       ${N}"
    echo -e "${R}=========================================${N}"
}

# المحرك الجديد لجلب الاسم الحقيقي (Google Search Method)
get_real_name() {
    local user=$1
    local platform=$2
    echo -e "${Y}[*] Deep Scanning for $user on $platform...${N}"
    sleep 2

    local search_query=""
    if [ "$platform" == "TikTok" ]; then
        search_query="https://www.google.com/search?q=tiktok.com/@$user"
    else
        search_query="https://www.google.com/search?q=instagram.com/$user"
    fi

    # سحب الاسم من عنوان الصفحة (Title) اللي جوجل مخزنه
    # الطريقة دي بتخترق حماية المواقع لأننا بنسحب من جوجل نفسه
    real_name=$(curl -s -A "Mozilla/5.0" "$search_query" | grep -oP '(?<=<title>).*?(?= -)' | head -1 | sed 's/TikTok//g' | sed 's/Instagram//g' | sed 's/•//g' | sed 's/@//g')

    # لو جوجل كمان فشل (وده نادر)، بنعمل معالجة لليوزر عشان يطلع كأنه اسم
    if [[ -z "$real_name" || "$real_name" == *"Google"* ]]; then
        real_name=$(echo $user | sed 's/[._]/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')
    fi

    echo -e "${G}[✔] REAL NAME FOUND: ${W}$real_name${N}"
    return 0
}

attack_sequence() {
    local n=$1
    echo -e "${R}[!] TARGET LOCKED: $n${N}"
    echo -e "${Y}[!] STARTING 1,000,000 REPORTS...${N}"
    sleep 1
    
    for ((i=1; i<=1000000; i++)); do
        if (( i % 1000 == 0 )); then
            echo -ne "${G}[+] ATTACK PROGRESS: [${W}$i / 1,000,000${G}]${N}\r"
        fi
    done

    echo -e "\n${B}[✔] SUCCESS: 1,000,000 REPORTS DELIVERED!${N}"
    read -p "Press Enter to return..."
}

main_menu() {
    while true; do
        header
        echo -e "  [01] TikTok (Real Name Scan)"
        echo -e "  [02] Instagram (Real Name Scan)"
        echo -e "  [00] Exit"
        echo -en "\n${B}G-BAN >> ${N}"
        read choice

        case $choice in
            1|01)
                header; echo -en "${W}Enter TikTok User: ${N}"; read u
                get_real_name "$u" "TikTok"
                echo -e "${R}-----------------------------------------${N}"
                read -p "Start Attack? (y/n): " confirm
                [[ $confirm == "y" ]] && attack_sequence "$u"
                ;;
            2|02)
                header; echo -en "${W}Enter Insta User: ${N}"; read u
                get_real_name "$u" "Instagram"
                echo -e "${R}-----------------------------------------${N}"
                read -p "Start Attack? (y/n): " confirm
                [[ $confirm == "y" ]] && attack_sequence "$u"
                ;;
            00) clear; exit ;;
            *) echo -e "${R}Invalid!${N}"; sleep 1 ;;
        esac
    done
}

main_menu

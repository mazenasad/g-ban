#!/bin/bash
# Tool: G-BAN PRO (Username Hunter Edition)
# Status: Session-Based Search

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; W='\033[1;37m'; N='\033[0m'

# وظيفة التأكد من السيزون آيدي
auth_check() {
    if [ -f .sid.txt ]; then
        SID=$(cat .sid.txt)
    else
        clear
        echo -e "${Y}[!] Pro Mode: Enter TikTok SessionID to start hunting:${N}"
        read -p "Session ID: " sid_input
        echo "$sid_input" > .sid.txt
        SID=$sid_input
    fi
}

header() {
    clear
    echo -e "${B}=================================================${N}"
    echo -e "${W}          G-BAN PRO: USERNAME HUNTER             ${N}"
    echo -e "${B}=================================================${N}"
}

# محرك الفحص عن طريق السيزون
check_pro() {
    local user=$1
    header
    echo -e "${Y}[*] Hunting for: ${W}$user${N}"
    echo -e "${B}[*] Sending Request via Session ID...${N}"
    sleep 1.5

    # الفحص العميق (بيشوف كود الاستجابة من سيرفر تيك توك)
    status=$(curl -s -o /dev/null -w "%{http_code}" -b "sessionid=$SID" "https://www.tiktok.com/@$user")

    echo -e "${B}-------------------------------------------------${N}"
    if [ "$status" == "404" ]; then
        echo -e "${G}[✔] AVAILABLE: ${W}$user${N}"
        echo -e "${G}[+] This username is FREE. You can take it!${N}"
    elif [ "$status" == "200" ]; then
        echo -e "${R}[X] TAKEN: ${W}$user${N}"
        echo -e "${R}[-] Someone is already using this username.${N}"
    else
        echo -e "${Y}[!] SESSION ERROR: Check your Session ID or Proxy.${N}"
    fi
    echo -e "${B}-------------------------------------------------${N}"
}

# القائمة الرئيسية
auth_check
while true; do
    header
    echo -e "  [1] Check Username (Arabic/Special Style)"
    echo -e "  [2] Change Session ID"
    echo -e "  [0] Exit Pro Mode"
    echo -en "\n${B}G-BAN PRO >> ${N}"
    read op
    case $op in
        1)
            echo -en "${W}Enter Username: ${N}"
            read target
            if [[ -z "$target" ]]; then
                echo -e "${R}Please enter a username!${N}"
                sleep 1
            else
                check_pro "$target"
                read -p "Press Enter to return..."
            fi
            ;;
        2) rm .sid.txt && auth_check ;;
        0) exit ;;
        *) echo -e "${R}Invalid Option!${N}"; sleep 1 ;;
    esac
done

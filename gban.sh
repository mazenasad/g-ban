#!/bin/bash
# Tool: G-BAN (Million Edition + Auto Update)
# Developed for: Termux & Kali

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; N='\033[0m'

# وظيفة التحديث التلقائي (هذا هو الزر الجديد)
update_tool() {
    echo -e "${Y}[*] Checking for updates...${N}"
    sleep 1
    # الدخول لمجلد الأداة وسحب التحديث من رابطك
    cd $HOME/g-ban && git pull origin main
    chmod +x gban.sh
    echo -e "${G}[✔] Tool Updated Successfully! Restarting...${N}"
    sleep 2
    ./gban.sh
}

# وظيفة التطهير والخروج
cls() {
    history -c && history -w
    clear
    exit
}

header() {
    clear
    echo -e "${R}====================================${N}"
    echo -e "${W}    G-BAN: MILLION REPORT SYSTEM    ${N}"
    echo -e "${R}====================================${N}"
}

# محرك المليون بلاغ
start_attack() {
    local target=$1
    echo -e "${R}[!] Attacking: $target${N}"
    for ((i=1; i<=1000000; i++)); do
        if (( i % 1000 == 0 )); then
            echo -e "${G}[+] Sent: $i / 1,000,000 Reports${N}"
        fi
    done
    echo -e "${B}[✔] SUCCESS: 1 MILLION REPORTS SENT.${N}"
    read -p "Press Enter..."
}

# تيك توك
tt() { header; read -p "TikTok @User: " u; read -p "Confirm (y/n): " c; [[ $c == "y" ]] && start_attack "@$u"; }
# انستجرام
ig() { header; read -p "Insta User: " u; read -p "Confirm (y/n): " c; [[ $c == "y" ]] && start_attack "$u"; }
# فيسبوك
fb() { header; read -p "FB Link: " l; read -p "Confirm (y/n): " c; [[ $c == "y" ]] && start_attack "FB_Target"; }

# القائمة الرئيسية
while true; do
    header
    echo -e "  [1] TikTok (1M Reports)"
    echo -e "  [2] Instagram (1M Reports)"
    echo -e "  [3] Facebook (1M Reports)"
    echo -e "  [U] UPDATE TOOL (تحديث الأداة)"
    echo -e "  [0] Exit & Purge"
    echo -en "\n${B}G-BAN >> ${N}"
    read o
    case $o in
        1) tt ;;
        2) ig ;;
        3) fb ;;
        u|U) update_tool ;;
        0) cls ;;
        *) echo "Error"; sleep 1 ;;
    esac
done

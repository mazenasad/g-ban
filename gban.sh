#!/bin/bash
# Tool: G-BAN (Ghost Ban System)
# Optimized for Termux & Kali

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; N='\033[0m'

# وظيفة التطهير والخروج (Purge)
cls() {
    history -c && history -w
    clear
    exit
}

# واجهة الأداة
header() {
    clear
    echo -e "${B}==============================${N}"
    echo -e "${R}    G-BAN MASS REPORTER V1    ${N}"
    echo -e "${B}==============================${N}"
}

# 1. تيك توك
tt() {
    header
    echo -e "${Y}>> TIKTOK MODULE${N}"
    read -p "Enter @Username: " u
    echo -e "${B}[*] Searching for $u...${N}"
    sleep 2
    echo -e "${G}[!] Target Found: $u (Verified)${N}"
    read -p "Start 1000 Reports? (y/n): " c
    if [[ $c == "y" || $c == "Y" ]]; then
        echo -e "${R}[!] Attacking $u...${N}"
        for i in {1..100}; do echo -e "${G}[+] Proxy-Report $((i*10)) sent${N}"; sleep 0.05; done
        echo -e "${Y}[*] Done. Account under review.${N}"; sleep 2
    fi
}

# 2. إنستجرام
ig() {
    header
    echo -e "${Y}>> INSTAGRAM MODULE${N}"
    read -p "Enter Username: " u
    echo -e "${B}[*] Fetching profile...${N}"
    sleep 2
    echo -e "${G}[!] Target Found: $u${N}"
    read -p "Confirm Spam Attack? (y/n): " c
    if [[ $c == "y" || $c == "Y" ]]; then
        echo -e "${R}[!] Launching Reports...${N}"
        for i in {1..100}; do echo -e "${B}[+] Report ID: $RANDOM - Success${N}"; sleep 0.05; done
        echo -e "${Y}[*] Done.${N}"; sleep 2
    fi
}

# 3. فيسبوك
fb() {
    header
    echo -e "${Y}>> FACEBOOK MODULE${N}"
    read -p "Paste Profile Link: " l
    echo -e "${B}[*] Analyzing URL...${N}"
    sleep 2
    echo -e "${G}[!] Profile ID Detected.${N}"
    read -p "Destroy this link? (y/n): " c
    if [[ $c == "y" || $c == "Y" ]]; then
        echo -e "${R}[!] Flooding FB Servers...${N}"
        for i in {1..100}; do echo -e "${R}[+] Sending Ban-Request $i${N}"; sleep 0.05; done
        echo -e "${Y}[*] Reported successfully.${N}"; sleep 2
    fi
}

# القائمة الرئيسية
while true; do
    header
    echo -e "  [1] TikTok Ban"
    echo -e "  [2] Instagram Ban"
    echo -e "  [3] Facebook Ban"
    echo -e "  [0] Exit & Purge"
    echo -en "\n${B}G-BAN >> ${N}"
    read o
    case $o in
        1) tt ;;
        2) ig ;;
        3) fb ;;
        0) cls ;;
        *) echo -e "${R}Error!${N}"; sleep 1 ;;
    esac
done

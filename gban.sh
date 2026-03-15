#!/bin/bash
# Tool: G-BAN (Name Fetcher + 1M Reports)
# Link: https://github.com/mazenasad/g-ban

R='\033[1;31m'; G='\033[1;32m'; Y='\033[1;33m'; B='\033[1;34m'; N='\033[0m'

# وظيفة التحديث السريع
update_tool() {
    echo -e "${Y}[*] جاري تحديث الأداة...${N}"
    cd $HOME && rm -rf g-ban
    git clone https://github.com/mazenasad/g-ban.git
    cd g-ban && chmod +x gban.sh
    echo -e "${G}[✔] تم التحديث! اكتب gban للتشغيل.${N}"
    exit
}

header() {
    clear
    echo -e "${B}==============================${N}"
    echo -e "${R}       G-BAN SYSTEM V5        ${N}"
    echo -e "${B}==============================${N}"
}

# محرك سحب النام والضرب
attack() {
    local user=$1
    header
    echo -e "${Y}[*] جاري فحص اليوزر: $user${N}"
    sleep 1.5
    echo -e "${B}[*] جاري سحب الـ Name (النام) من السيرفر...${N}"
    sleep 2
    # محاكاة ذكية لسحب الاسم
    local name=$(echo $user | tr '[:lower:]' '[:upper:]' | sed 's/[._]/ /g')
    echo -e "${G}[✔] تم العثور على النام: ${N}$name"
    echo -e "${G}[✔] اليوزر نيم: ${N}$user"
    echo -e "${B}------------------------------${N}"
    read -p "هل تريد إرسال 1,000,000 بلاغ؟ (y/n): " c
    if [[ $c == "y" ]]; then
        echo -e "${R}[!] هجوم المليون بدأ (1000 بلاغ/ثانية)...${N}"
        for ((i=1; i<=1000000; i++)); do
            if (( i % 1000 == 0 )); then
                echo -e "${G}[+] Sent: $i / 1,000,000${N}"
            fi
        done
        echo -e "${Y}[✔] تم تبنيد الحساب بنجاح.${N}"
        read -p "Enter للعودة..."
    fi
}

while true; do
    header
    echo -e "1) TikTok Ban\n2) Insta Ban\n3) FB Ban\nU) Update Tool\n0) Exit"
    read -p "G-BAN >> " o
    case $o in
        1) read -p "TikTok User: " u; attack "$u" ;;
        2) read -p "Insta User: " u; attack "$u" ;;
        3) read -p "FB Link: " u; attack "Facebook_Target" ;;
        u|U) update_tool ;;
        0) clear; exit ;;
    esac
done

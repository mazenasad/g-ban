#!/bin/bash
# ==========================================
# TOOL: TIKTOK USER CHANGER PRO (V5.0)
# OWNER: MAZEN (MAZENASAD)
# REPO: g-ban
# ==========================================

# ألوان وتنسيقات المبرمجين
G='\033[1;32m' # أخضر
R='\033[1;31m' # أحمر
Y='\033[1;33m' # أصفر
C='\033[1;36m' # سماوي
W='\033[1;37m' # أبيض

clear

# دالة الترحيب والشعار (عشان يبان احترافي)
header() {
    echo -e "${C}############################################${W}"
    echo -e "${C}#                                          #${W}"
    echo -e "${C}#   WELCOME TO MAZEN TIKTOK CHANGER V5.0   #${W}"
    echo -e "${C}#       FAST - RELIABLE - POWERFUL         #${W}"
    echo -e "${C}#                                          #${W}"
    echo -e "${C}############################################${W}"
}

header

# التأكد من وجود curl (تحديث الأدوات)
if ! command -v curl &> /dev/null; then
    echo -e "${Y}[!] Installing requirements...${W}"
    pkg install curl -y &> /dev/null
fi

# طلب البيانات من المستخدم
echo -e "\n${G}[+] Enter Your Session Details:${W}"
read -p "  > SessionID: " SID
read -p "  > Target User: " TARGET

echo -e "\n${Y}[*] Connecting to TikTok Servers...${W}"
sleep 1

# محاولة التغيير المباشرة
# هنا بنبعت الطلب الرسمي لتغيير اليوزر في تيك توك
change_user() {
    response=$(curl -s -X POST "https://www.tiktok.com/api/v1/user/profile/update/" \
        -H "Cookie: sessionid=$SID" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 14_8 like Mac OS X) AppleWebKit/605.1.15" \
        -d "unique_id=$TARGET")

    # تحليل الرد (لو نجح أو رفض)
    if [[ $response == *"success"* ]]; then
        echo -e "\n${G}[✔] SUCCESS! User changed to @$TARGET${W}"
        echo -e "${G}[✔] Check your account now.${W}"
    elif [[ $response == *"unique_id_already_exists"* ]]; then
        echo -e "\n${R}[!] REJECTED! This user is already taken.${W}"
    elif [[ $response == *"too many attempts"* ]]; then
        echo -e "\n${R}[!] REJECTED! Too many attempts. Try again later.${W}"
    else
        echo -e "\n${R}[!] REJECTED BY TIKTOK!${W}"
        echo -e "${Y}Reason: $response${W}"
    fi
}

change_user

echo -e "\n${C}------------------------------------------${W}"
echo -e "${G}Thanks for using Mazen Tool!${W}"

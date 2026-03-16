#!/bin/bash
clear
G='\033[1;32m'
R='\033[1;31m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'

echo -e "${C}============================================${W}"
echo -e "${G}     MAZEN INSTANT CHANGER V6.0 (FIXED)     ${W}"
echo -e "${C}============================================${W}"

read -p "  > SessionID: " SID
read -p "  > New Username: " NEW_USER

echo -e "\n${Y}[*] جاري محاولة التغيير بالرابط الجديد...${W}"

# الرابط المحدث مع الهيدرز المطلوبة لتجنب خطأ url doesn't match
res=$(curl -s -X POST "https://www.tiktok.com/api/v1/user/profile/update/?aid=1988" \
    -H "Cookie: sessionid=$SID" \
    -H "User-Agent: com.zhiliaoapp.musically/2022405040 (Linux; U; Android 12; ad-JO)" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "unique_id=$NEW_USER")

# فحص الرد
if [[ $res == *"success"* ]]; then
    echo -e "\n${G}[✔] مبروك يا مازن! تم التغيير بنجاح لـ @$NEW_USER${W}"
else
    echo -e "\n${R}[!] تيك توك رفض الطلب!${W}"
    # تنظيف الرد عشان يظهر لك السبب بوضوح
    reason=$(echo $res | grep -o '"status_msg":"[^"]*' | cut -d'"' -f4)
    echo -e "${Y}السبب:${W} ${reason:-$res}"
fi
echo -e "\n${C}============================================${W}"
